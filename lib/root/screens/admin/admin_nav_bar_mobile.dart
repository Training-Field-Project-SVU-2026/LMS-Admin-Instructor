import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/home/ttt.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/instructor_admin_screen.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/screens/student_admin_screen.dart';

class AdminNavBarMobile extends StatefulWidget {
  const AdminNavBarMobile({super.key});

  @override
  State<AdminNavBarMobile> createState() => _AdminNavBarMobileState();
}

class _AdminNavBarMobileState extends State<AdminNavBarMobile> {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<Widget> screens = const [
    Ttt(),
    InstructorAdminScreen(),
    StudentAdminScreen(),
    Ttt(),
    Ttt(),
  ];

  void changePage(int index) {
    if (currentIndex == index) return;
    setState(() {
      currentIndex = index;
    });

    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: context.isDesktop
          ? null
          : AdminNavBarMobileUi(currentIndex: currentIndex, onTap: changePage),
    );
  }
}

class AdminNavBarMobileUi extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdminNavBarMobileUi({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          height: 80.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(alpha: 0.08),
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.isTablet ? 500.w : double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navItem(
                    icon: Icons.dashboard_outlined,
                    label: 'dashboard',
                    index: 0,
                    context: context,
                  ),
                  navItem(
                    icon: Icons.groups_outlined,
                    label: "instructors",
                    index: 1,
                    context: context,
                  ),
                  navItem(
                    icon: Icons.menu_book_outlined,
                    label: "courses",
                    index: 2,
                    context: context,
                  ),
                  navItem(
                    icon: Icons.school_outlined,
                    label: "students",
                    index: 3,
                    context: context,
                  ),
                  navItem(
                    icon: Icons.settings_outlined,
                    label: "settings",
                    index: 4,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String label,
    required int index,
    required BuildContext context,
  }) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.surface.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface.withValues(alpha: 0.5),
              size: 26.sp,
            ),
            if (isSelected) ...[
              SizedBox(height: 4.h),
              Text(
                context.tr(label),
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
