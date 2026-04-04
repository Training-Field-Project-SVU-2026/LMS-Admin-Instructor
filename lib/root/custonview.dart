import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/root/navbar.dart';
import 'package:lms_admin_instructor/root/root_after_login.dart';

class Customview extends StatefulWidget {
  const Customview({super.key});

  @override
  State<Customview> createState() => _CustomviewState();
}

class _CustomviewState extends State<Customview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isDesktop(context) ? AdminDashboard() : RootAfterLogin(),
    );
  }
}
