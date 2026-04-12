import 'package:flutter/widgets.dart';
import 'package:lms_admin_instructor/root/models/nav_items.dart';
import 'package:lms_admin_instructor/root/screens/admin_root_screen.dart';

class CustomViewNavBar extends StatefulWidget {
  final String role;
  const CustomViewNavBar({super.key, required this.role});

  @override
  State<CustomViewNavBar> createState() => _CustomViewNavBarState();
}

class _CustomViewNavBarState extends State<CustomViewNavBar> {
  @override
  Widget build(BuildContext context) {
    return RootScreen(
      navItems: widget.role == 'admin' ? adminNavItems : instructorNavItems,
    );
  }
}
