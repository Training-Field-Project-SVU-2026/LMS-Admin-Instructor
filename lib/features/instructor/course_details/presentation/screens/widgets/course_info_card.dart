import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CourseInfoCard extends StatelessWidget {
  const CourseInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          context.tr('level_3_placeholder'),
                          style: TextStyle(
                            color: context.colorScheme.surface,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: Text(
                          context.tr('level_3_placeholder'),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('course_title_placeholder'),
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              _buildHeaderButton(
                                context,
                                context.tr('edit_details'),
                                false,
                                () {},
                              ),
                              SizedBox(width: 12.w),
                              _buildHeaderButton(
                                context,
                                context.tr('add_content'),
                                true,
                                () {},
                                icon: Icons.add,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        context.tr('course_desc_placeholder'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          _buildInfoBadge(
                            context,
                            Icons.category_outlined,
                            "${context.tr('category_label')}${context.tr('category_web_dev')}",
                          ),
                          SizedBox(width: 24.w),
                          _buildInfoBadge(
                            context,
                            Icons.signal_cellular_alt,
                            "${context.tr('level_label')}${context.tr('level_advanced')}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(
                  icon: Icons.play_circle_filled,
                  label: context.tr('total_videos'),
                  value: "24",
                  color: Colors.blue.shade50,
                  iconColor: Colors.blue,
                ),
                _StatItem(
                  icon: Icons.assignment,
                  label: context.tr('total_quizzes'),
                  value: "5",
                  color: Colors.purple.shade50,
                  iconColor: Colors.purple,
                ),
                _StatItem(
                  icon: Icons.folder,
                  label: context.tr('materials'),
                  value: "12",
                  color: Colors.orange.shade50,
                  iconColor: Colors.orange,
                ),
                _StatItem(
                  icon: Icons.people,
                  label: context.tr('students_enrolled'),
                  value: "1,240",
                  color: Colors.green.shade50,
                  iconColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(
    BuildContext context,
    String text,
    bool isPrimary,
    VoidCallback onTap, {
    IconData? icon,
  }) {
    return SizedBox(
      height: 40.h,
      child: isPrimary
          ? CustomPrimaryButton(
              onTap: onTap,
              text: text,
              prefixIcon: icon != null
                  ? Icon(icon, size: 18.sp, color: context.colorScheme.surface)
                  : null,
              width: 140.w,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.colorScheme.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              child: Text(
                text,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
    );
  }

  Widget _buildInfoBadge(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color iconColor;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Text(
                value,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
