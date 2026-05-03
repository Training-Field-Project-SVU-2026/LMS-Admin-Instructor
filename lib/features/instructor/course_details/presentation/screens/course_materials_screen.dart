import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_material_bloc/course_material_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_material_bloc/course_material_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_material_bloc/course_material_state.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_material_section/upload_material_dialog.dart';

class CourseMaterialsScreen extends StatefulWidget {
  final String slug;
  final String courseName;
  const CourseMaterialsScreen({
    super.key,
    required this.slug,
    required this.courseName,
  });

  @override
  State<CourseMaterialsScreen> createState() => _CourseMaterialsScreenState();
}

class _CourseMaterialsScreenState extends State<CourseMaterialsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isChanged = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<CourseMaterialsBloc>();
      final state = bloc.state;
      if (state is CourseMaterialsLoaded && !state.isPaginationLoading) {
        if (state.materialsListUIModel.currentPage <
            state.materialsListUIModel.totalPages) {
          bloc.add(
            GetCourseMaterialsEvent(
              slug: widget.slug,
              page: state.materialsListUIModel.currentPage + 1,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.pop(_isChanged);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.4,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: IconButton(
              onPressed: () => context.pop(_isChanged),
              icon: Icon(Icons.arrow_back_ios_new, size: 18.sp),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                color: context.colorScheme.secondary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => _showUploadDialog(context),
                icon: Icon(
                  Icons.add_rounded,
                  color: context.colorScheme.onSecondary,
                ),
                tooltip: context.tr('upload_new_material'),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocListener<CourseMaterialsBloc, CourseMaterialsState>(
                listener: (context, state) {
                  if (state is DeleteMaterialSuccess) {
                    _isChanged = true;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    context.read<CourseMaterialsBloc>().add(
                      GetCourseMaterialsEvent(slug: widget.slug, page: 1),
                    );
                  } else if (state is DeleteMaterialError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: BlocBuilder<CourseMaterialsBloc, CourseMaterialsState>(
                  builder: (context, state) {
                    if (state is CourseMaterialsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CourseMaterialsError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is CourseMaterialsLoaded) {
                      final materials = state.materialsListUIModel.materials;

                      if (materials.isEmpty) {
                        return _buildEmptyState();
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        itemCount:
                            materials.length +
                            (state.isPaginationLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < materials.length) {
                            return _buildMaterialCard(
                              context,
                              materials[index],
                            );
                          } else {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.courseName,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr('course_materials'),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSecondary.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 64.sp,
            color: context.colorScheme.outline.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            context.tr('no_materials_found'),
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
    BuildContext context,
    CourseMaterialItemUIModel material,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (material.file != null) {
              context.pushNamed(
                AppRoutes.pdfViewer,
                extra: {'url': material.file, 'title': material.materialName},
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: context.colorScheme.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.materialName,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            material.fileSize ?? '0 KB',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (material.createdAt != null) ...[
                            Text(
                              ' • ',
                              style: TextStyle(
                                color: context.colorScheme.outline,
                              ),
                            ),
                            Text(
                              material.createdAt!.split('T')[0],
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(
                      icon: Icons.edit_note_outlined,
                      color: context.colorScheme.outlineVariant.withValues(
                        alpha: 0.5,
                      ),
                      onTap: () {
                        // TODO: Implement Edit
                      },
                    ),
                    SizedBox(width: 8.w),
                    _buildActionButton(
                      icon: Icons.delete_rounded,
                      color: context.colorScheme.error,
                      onTap: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Material'),
                            content: const Text(
                              'Are you sure you want to delete this material?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => context.pop(false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => context.pop(true),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: context.colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          context.read<CourseMaterialsBloc>().add(
                            DeleteMaterialEvent(
                              courseSlug: widget.slug,
                              materialSlug: material.slug,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Icon(icon, size: 20.sp, color: color),
      ),
    );
  }

  void _showUploadDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<CourseMaterialsBloc>(),
        child: UploadMaterialDialog(courseSlug: widget.slug),
      ),
    );

    if (result == true && context.mounted) {
      _isChanged = true;
      context.read<CourseMaterialsBloc>().add(
        GetCourseMaterialsEvent(slug: widget.slug, page: 1),
      );
    }
  }
}
