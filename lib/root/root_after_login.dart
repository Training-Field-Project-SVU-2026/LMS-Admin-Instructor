import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/home/ttt.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/admin_insructor_screen.dart';
import 'package:lms_admin_instructor/root/custom_nav_bar.dart';

class RootAfterLogin extends StatefulWidget {
  const RootAfterLogin({super.key});

  @override
  State<RootAfterLogin> createState() => _RootAfterLoginState();
}

class _RootAfterLoginState extends State<RootAfterLogin> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Widget> screens = [
    const Ttt(),
    const AdminInsructorScreen(),
    const Ttt(),
    const Ttt(),
    const Ttt(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });

    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: CustomNavBarMobile(
        currentIndex: currentIndex,
        onTap: changePage,
      ),
    );
  }
}
