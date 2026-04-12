import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/root/screens/admin/admin_nav_bar_desktop.dart';
import 'package:lms_admin_instructor/root/screens/admin/admin_nav_bar_mobile.dart';

class CustomViewNavBar extends StatefulWidget {
  const CustomViewNavBar({super.key});

  @override
  State<CustomViewNavBar> createState() => _CustomViewNavBarState();
}

class _CustomViewNavBarState extends State<CustomViewNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isDesktop
          ? const AdminNavBarDesktop()
          : const AdminNavBarMobile(),
    );
  }
}
