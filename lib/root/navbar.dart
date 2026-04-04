import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/home/ttt.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Ttt(),
    const Ttt(),
    const Ttt(),
    const Ttt(),
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
      width: 280,
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 32, 28, 24),
            child: Text(
              'LMS Admin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Divider(
            color: context.colorScheme.onSurface,
            height: 1,
            thickness: 1,
            indent: 24,
            endIndent: 24,
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                NavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  index: 0,
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTap(0),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.person_outline,
                  label: 'Instructors',
                  index: 1,
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTap(1),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.school_outlined,
                  label: 'Students',
                  index: 2,
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTap(2),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.menu_book_outlined,
                  label: 'Courses',
                  index: 3,
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTap(3),
                ),
                SizedBox(height: 8.h),
                NavItem(
                  icon: Icons.campaign_outlined,
                  label: 'Announcement',
                  index: 4,
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemTap(4),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Divider(color: Colors.white24, height: 1, thickness: 1),
                SizedBox(height: 16.h),
                NavItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  index: 5,
                  isSelected: selectedIndex == 5,
                  onTap: () => onItemTap(5),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF3B82F6),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin User',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'admin@lms.com',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            ? context.colorScheme.primary.withValues(alpha: 0.3)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 22,
                ),
                SizedBox(width: 5.w),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? context.colorScheme.onSurface.withValues(alpha: 0.8)
                        : context.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
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
