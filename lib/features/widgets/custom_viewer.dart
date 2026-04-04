import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/customl_istview.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

class CustomViewer extends StatefulWidget {
  final int num1;
  final int num2;
  final int num3;
  final List<String> instructorInfo;
  // TODO This will come from the Cubit
  final List<User> userData;
  const CustomViewer({super.key, this.num1 = 1, this.num2 = 5, this.num3 = 124, required this.instructorInfo, required this.userData});

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
            mobileSize: 650,
          ),
          // 1104.w,
          height: getResponsiveSize(
            context: context,
            webSize: 949,
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
                      widget.instructorInfo.length,
                      (index) => Expanded(
                        child: Center(
                          child: Text(
                            widget.instructorInfo[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: CustomListView(controller: _listController, userData: widget.userData)),
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

