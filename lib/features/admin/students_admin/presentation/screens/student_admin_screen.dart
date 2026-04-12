import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/screens/student_admin_desktop_screen.dart';

class StudentAdminScreen extends StatefulWidget {
  const StudentAdminScreen({super.key});

  @override
  State<StudentAdminScreen> createState() => _StudentAdminScreenState();
}

class _StudentAdminScreenState extends State<StudentAdminScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudentAdminDesktopScreen(),
      // context.isDesktop
      //     ? StudentAdminDesktopScreen()
      //     : StudentAdminMobileScreen(),
    );
  }
}
