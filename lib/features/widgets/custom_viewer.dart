import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/customl_istview.dart';

// ignore: must_be_immutable
class CustomViewer extends StatefulWidget {
  int num1 = 1;
  int num2 = 5;
  int num3 = 124;
  CustomViewer({super.key});

  @override
  State<CustomViewer> createState() => _CustomViewerState();
}

class _CustomViewerState extends State<CustomViewer> {
  late LinkedScrollControllerGroup _controllersGroup;
  late ScrollController _headerController;
  late ScrollController _listController;
  late ScrollController _footerController;

  @override
  void initState() {
    super.initState();
    _controllersGroup = LinkedScrollControllerGroup();
    _headerController = _controllersGroup.addAndGet();
    _listController = _controllersGroup.addAndGet();
    _footerController = _controllersGroup.addAndGet();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _listController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  List<String> instructorInfo = [
    "Instructor Name",
    "BIO",
    "Join Date",
    "email",
    "Actions",
  ];

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
            tabletSize: 800,
            mobileSize: 650,
          ),
          // 1104.w,
          height: getResponsiveSize(
            context: context,
            webSize: 949,
            tabletSize: 600,
            mobileSize: 550,
          ),
          // 949.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(width: 1, color: Color(0xff94A3B8)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SingleChildScrollView(
                controller: _headerController,
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: getResponsiveSize(
                    context: context,
                    webSize: 1104,
                    tabletSize: 800,
                    mobileSize: 650,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.r,
                    horizontal: 20.r,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD1DDE1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: List.generate(
                      instructorInfo.length,
                      (index) => Expanded(
                        child: Center(child: Text(instructorInfo[index])),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: CustomListView(controller: _listController)),
              const Divider(color: Color(0xff94A3B8)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                width: double.infinity,
                height: 80.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: _footerController,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        // التريك هنا: بنقول للكونتينر اللي جوه السكرول "أقل عرض ليك هو عرض الشاشة"
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Showing ${widget.num1} to ${widget.num2} of ${widget.num3} results",
                              style: context.textTheme.bodyMedium,
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
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
                                      horizontal: 12,
                                      vertical: 8,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
