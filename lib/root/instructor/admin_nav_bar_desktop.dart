import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/home/ttt.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/instructor_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/screens/student_admin_screen.dart';

class AdminNavBarDesktop extends StatefulWidget {
  const AdminNavBarDesktop({super.key});

  @override
  State<AdminNavBarDesktop> createState() => _AdminNavBarDesktopState();
}

class _AdminNavBarDesktopState extends State<AdminNavBarDesktop> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Ttt(),
    const InstructorAdminScreen(),
    const StudentAdminScreen(),
    const Ttt(),
    const Ttt(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationBarWidget(
            selectedIndex: _selectedIndex,
            onItemTap: _onItemTapped,
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

class NavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const NavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28.w, 32.h, 28.w, 24.h),
            child: Text(
              context.tr('lms_admin'),
              style: context.textTheme.displaySmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Divider(
            color: context.colorScheme.onSurface.withValues(alpha: 0.1),
            height: 1,
            thickness: 1,
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                NavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'dashboard',
                  index: 0,
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTap(0),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.person_outline,
                  label: 'instructors',
                  index: 1,
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTap(1),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.school_outlined,
                  label: 'students',
                  index: 2,
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTap(2),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.menu_book_outlined,
                  label: 'courses',
                  index: 3,
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTap(3),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.campaign_outlined,
                  label: 'announcement',
                  index: 4,
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemTap(4),
                ),
              ],
            ),
          ),
          const Spacer(),
          Divider(
            color: context.colorScheme.onSurface.withValues(alpha: 0.1),
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                NavItem(
                  icon: Icons.settings_outlined,
                  label: 'settings',
                  index: 5,
                  isSelected: selectedIndex == 5,
                  onTap: () => onItemTap(5),
                ),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: context.colorScheme.primary,
                        child: Icon(
                          Icons.person,
                          color: context.colorScheme.onPrimary,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // TODO Replace this with proifile
                            context.push(AppRoutes.loginScreen);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Admin User',
                                style: context.textTheme.titleMedium,
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                'admin@lms.com',
                                style: context.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: isSelected
            ? context.colorScheme.primary.withValues(alpha: 0.15)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    context.tr(label),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
