import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/admin_instructor_mobile.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/admin_instructors_web.dart';

class AdminInsructorScreen extends StatefulWidget {
  const AdminInsructorScreen({super.key});

  @override
  State<AdminInsructorScreen> createState() => _AdminInsructorScreenState();
}

class _AdminInsructorScreenState extends State<AdminInsructorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isDesktop(context)
          ? AdminInstructorsWeb()
          : AdminInstructorMobile(),
    );
  }
}
