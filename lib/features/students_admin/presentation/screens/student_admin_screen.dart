import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_bloc.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_event.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/screens/student_admin_desktop_screen.dart';

class StudentAdminScreen extends StatefulWidget {
  const StudentAdminScreen({super.key});

  @override
  State<StudentAdminScreen> createState() => _StudentAdminScreenState();
}

class _StudentAdminScreenState extends State<StudentAdminScreen> {

  @override
  void initState() {
    super.initState();
    context.read<StudentAdminBloc>().add(GetStudentsAdminEvent());
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
