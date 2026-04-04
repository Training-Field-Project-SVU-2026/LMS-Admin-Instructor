import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/root/navbar.dart';

class Custonview extends StatefulWidget {
  const Custonview({super.key});

  @override
  State<Custonview> createState() => _CustonviewState();
}

class _CustonviewState extends State<Custonview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: isDesktop(context) ? AdminDashboard() : SizedBox());
  }
}
