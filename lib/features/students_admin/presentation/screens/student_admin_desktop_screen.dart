import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_bloc.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_event.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_add_row/custom_add_row_widget.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';
import 'package:lms_admin_instructor/features/widgets/custom_search_app_bar.dart';

class StudentAdminDesktopScreen extends StatefulWidget {
  const StudentAdminDesktopScreen({super.key});

  @override
  State<StudentAdminDesktopScreen> createState() =>
      _StudentAdminDesktopScreenState();
}

class _StudentAdminDesktopScreenState extends State<StudentAdminDesktopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<StudentAdminBloc>().add(GetStudentsAdminEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<StudentAdminBloc>().state;
      if (state is StudentAdminLoaded && !state.isPaginationLoading) {
        context.read<StudentAdminBloc>().add(
          GetStudentsAdminEvent(
            page: state.studentAdminUIModel.currentPage + 1,
          ),
        );
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
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomSearchAppBar(
          hint: context.tr('search_by_name'),
          controller: TextEditingController(),
        ),
        toolbarHeight: 70.h,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAddRowWidget(
              title: context.tr('manage_students'),
              description: context.tr(
                "create_update_manage_student_profiles_assignments",
              ),
              buttonText: context.tr('add_student'),
              icon: Icons.people_outline,
              onTap: () {
                context.push(AppRoutes.addStudentAdminScreen);
              },
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                //! Watch out, this widget place not here
                // CustomCardDesktop(
                //   title: context.tr('total_students'),
                //   value: "120",
                //   icon: Icons.people_outline,
                //   color: context.colorScheme.primary
                // ),
                // SizedBox(width: 20.w),
                // CustomCardDesktop(
                //   title: context.tr('total_courses'),
                //   value: "48",
                //   icon: Icons.book_outlined,
                //   color: context.colorScheme.primary
                // ),
              ],
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: BlocBuilder<StudentAdminBloc, StudentAdminState>(
                builder: (context, state) {
                  if (state is StudentAdminLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentAdminError) {
                    return Center(child: Text(state.message));
                  } else if (state is StudentAdminLoaded) {
                    return CustomDataTable(
                      headers: [
                        context.tr('student_name'),
                        context.tr('email_label'),
                        context.tr('status'),
                      ],
                      columnFlex: const [3, 4, 1],
                      data: state.studentAdminUIModel.students
                          .cast<CustomDataTableRowModel>(),
                      scrollController: _scrollController,
                      isPaginationLoading: state.isPaginationLoading,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
