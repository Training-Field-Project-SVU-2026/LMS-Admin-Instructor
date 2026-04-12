import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/instructor_card.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class InstructorMobileAdminScreen extends StatefulWidget {
  const InstructorMobileAdminScreen({super.key});

  @override
  State<InstructorMobileAdminScreen> createState() =>
      _InstructorMobileAdminScreenState();
}

class _InstructorMobileAdminScreenState
    extends State<InstructorMobileAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('all_instructors'),
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: InkWell(
              onTap: () {},
              child: CustomImage(
                aspectRatio: 1,
                imagePath:
                    "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                width: 45,
                height: 45,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ],
      ),
      //**************************************?? ADD INSTRUCTORS CARDS??********************************************??
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colorScheme.onSecondary,

        onPressed: () {
          context.push(AppRoutes.addInstructorAdminScreen);
        },
        child: Icon(Icons.person_add_alt, color: context.colorScheme.surface),
      ),
      //**************************************?? BODY??********************************************??
      body: Padding(
        padding: EdgeInsets.only(top: 22.h, left: 22.w, right: 20.w),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //***************************************??HEADERr PAGE??********************************************??
                Text(
                  context.tr('manage_instructors'),
                  style: context.textTheme.displayMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  context.tr('create_update_manage_instructor_profiles_assignments'),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                SizedBox(height: 24.h),

                //**************************************??TOTAL VIDEOS AND TOTAL COURSES CARDS??********************************************??
                Row(
                  children: [
                    CustomCardStatusInfoMobile(
                      colortitle: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      colornum: context.colorScheme.surface,
                      colorIcon: context.colorScheme.surface.withValues(
                        alpha: 0.5,
                      ),
                      icon: Icons.person,
                      title: context.tr('total_instructors'),
                      num: "100",
                      color1: context.colorScheme.primary,
                      color2: Color(0xFF117A8B),
                      color3: context.colorScheme.primary.withValues(
                        alpha: 0.6,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    CustomCardStatusInfoMobile(
                      colortitle: context.colorScheme.onSecondary.withValues(
                        alpha: 0.7,
                      ),
                      colornum: context.colorScheme.primary,
                      colorIcon: context.colorScheme.onSecondary,
                      icon: Icons.book_outlined,
                      title: context.tr('total_courses'),
                      num: "48",
                      color1: context.colorScheme.secondary,
                      color2: Color(0xFFB7EF9C).withValues(alpha: 0.6),
                      color3: context.colorScheme.surface,
                    ),
                  ],
                ),

                //**************************************?? INSTRUCTORS CARDS??********************************************??
                SizedBox(height: 16.h),
                SizedBox(
                  width: 342.w,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: InstructorCard(
                          onTap: () {
                            context.push(
                              AppRoutes.profileInstructorAdminScreen,
                            );
                          },
                          name: "Dr. Elena Rodriguez",
                          description:
                              "Specializing in Neural Networks and Deep Learning architectures for the",
                          image:
                              "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                          courses: 12,
                        ),
                      );
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
