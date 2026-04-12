import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/search_bar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
        child: Row(
          children: [
            CustomSearchBarr(
              w: 383,
              h: 40,
              hint: context.tr('search_instructors_hint'),

              controller: TextEditingController(),
              prefixIcon: Icons.search,
              r: 30,
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                // هنا هحط منطق تغيير الثيم
              },
            ),
          ],
        ),
      ),
    );
  }
}
