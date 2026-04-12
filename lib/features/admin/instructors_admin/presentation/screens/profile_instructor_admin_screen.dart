import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/profile_instructor_disctop_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/profile_instructor_moblie_admin_screen.dart';

class ProfileInstructorAdminScreen extends StatefulWidget {
  const ProfileInstructorAdminScreen({super.key});

  @override
  State<ProfileInstructorAdminScreen> createState() =>
      _ProfileInstructorAdminScreenState();
}

class _ProfileInstructorAdminScreenState
    extends State<ProfileInstructorAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isDesktop
          ? const ProfileInstructorDisctopAdminScreen()
          : const ProfileInstructorMoblieAdminScreen(),
    );
  }
}
