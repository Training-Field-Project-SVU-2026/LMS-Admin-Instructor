import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_information_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_status_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_card.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class ProfileInstructorMoblieAdminScreen extends StatefulWidget {
  final String slug;
  const ProfileInstructorMoblieAdminScreen({super.key, required this.slug});

  @override
  State<ProfileInstructorMoblieAdminScreen> createState() =>
      _ProfileInstructorMoblieAdminScreenState();
}

class _ProfileInstructorMoblieAdminScreenState
    extends State<ProfileInstructorMoblieAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.01),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //***********************************??Instructor Informations??*****************
                  CustomInstructorInformationMobile(
                    name: "Ahmed Mohamed",
                    title: "Senior Software Engineering Instructor ",
                    image:
                        "https://i.pinimg.com/736x/cc/5b/67/cc5b67c3391fccebb5e03b0bd92c528b.jpg",
                  ),
                  SizedBox(height: 24.h),

                  //***********************************??Instructor Status??*****************
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomInstructorStatusMobile(
                        title: "Total Students",
                        num: "10111",
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.08,
                        ),
                        colorIcon: context.colorScheme.primary,
                        colornum: context.colorScheme.primary,
                        colortitle: context.colorScheme.onSurface,
                        icon: Icons.group,
                      ),
                      CustomInstructorStatusMobile(
                        title: "Total Courses",
                        num: "10",
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.08,
                        ),
                        colorIcon: context.colorScheme.onSecondary.withValues(
                          alpha: 0.8,
                        ),
                        colornum: context.colorScheme.primary,
                        colortitle: context.colorScheme.onSurface,
                        icon: Icons.star,
                      ),
                    ],
                  ),

                  //***********************************??Instructor courses??*****************
                  SizedBox(height: 24.h),
                  CustomCard(
                    bottom_action: "Course ",
                    icon: Icons.person,
                    total_num: 10,
                    onTap: () {},
                    title: "Flutter",
                    description:
                        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
                    image:
                        "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                  ),
                  SizedBox(height: 24.h),
                  CustomCard(
                    bottom_action: "Course ",
                    icon: Icons.person,
                    total_num: 10,
                    onTap: () {},
                    title: "Flutter",
                    description:
                        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
                    image:
                        "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                  ),
                  SizedBox(height: 24.h),
                  CustomCard(
                    bottom_action: "Course ",
                    icon: Icons.person,
                    total_num: 10,
                    onTap: () {},
                    title: "Flutter",
                    description:
                        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
                    image:
                        "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                  ),
                  SizedBox(height: 24.h),
                  CustomCard(
                    bottom_action: "Course ",
                    icon: Icons.person,
                    total_num: 10,
                    onTap: () {},
                    title: "Flutter",
                    description:
                        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
                    image:
                        "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                  ),
                  SizedBox(height: 24.h),
                  CustomCard(
                    bottom_action: "Course ",
                    icon: Icons.person,
                    total_num: 10,
                    onTap: () {},
                    title: "Flutter",
                    description:
                        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
                    image:
                        "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                  ),
                ],
              ),
            ),
            //***********************************??Delete Instructor??*****************
            SizedBox(height: 24.h),
            CustomPrimaryButton(
              text: "Delete Instructor",
              onTap: () {},
              width: 300,
              height: 50,
              prefixIcon: Icon(Icons.delete),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.error.withValues(
                  alpha: 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
