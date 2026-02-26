import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_restponsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/widgets/customl_istview.dart';

class CustomViewer extends StatefulWidget {
  const CustomViewer({super.key});

  @override
  State<CustomViewer> createState() => _CustomViewerState();
}

class _CustomViewerState extends State<CustomViewer> {
  List<String> instructorInfo = [
    "Instructor Name",
    "BIO",
    "Join Date",
    "email",
    "Actions",
  ];
  int num1 = 1;
  int num2 = 5;
  int num3 = 124;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Viewer')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Container(
          width: getResponsiveSize(
            context: context,
            webSize: 1104,
            tabletSize: 700,
            mobileSize: 350,
          ),
          // 1104.w,
          height: getResponsiveSize(
            context: context,
            webSize: 949,
            tabletSize: 400,
            mobileSize: 250,
          ),
          // 949.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(width: 1, color: Color(0xff94A3B8)),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
                decoration: BoxDecoration(
                  color: Color(0xFFD1DDE1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: List.generate(
                      instructorInfo.length,
                      (index) => Expanded(
                        child: Center(
                          child: Text(
                            instructorInfo[index],
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: CustomListView()),
              const Divider(color: Color(0xff94A3B8)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                width: double.infinity,
                height: 80.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left Text
                    Text(
                      "Showing $num1 to $num2 of $num3 results",
                      style: context.textTheme.bodyMedium,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Previous"),
                        ),

                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Next"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
