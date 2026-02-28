import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

// ignore: must_be_immutable
class CustomListView extends StatelessWidget {
  final ScrollController controller;
  CustomListView({Key? key, required this.controller}) : super(key: key);
  List<Instructor> instructordata = [
    Instructor(
      name: "Abdallah ALQiran",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.ALQiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Abdallah ",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.Qiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Abdallah ",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.Qiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Abdallah ",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.Qiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Abdallah ",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.Qiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Abdallah ",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "Abdallah.Qiran@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Taha Saber",
      bio: "Flutter",
      date: "12 Jan 2023",
      email: "taha.saber@gmail.com",
      image: '',
      action: "Active",
    ),
    Instructor(
      name: "Mayar abdelrah ",
      bio: "Flutter",
      date: "5 Mar 2022",
      email: "Mayar abdelrah@gmail.com",
      image: '',
      action: "Active",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: getResponsiveSize(
            context: context,
            webSize: 1104,
            tabletSize: 800,
            mobileSize: 650,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: instructordata.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const CircleAvatar(child: Icon(Icons.person)),
                          SizedBox(width: 8.w),

                          Expanded(
                            child: Text(
                              instructordata[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          instructordata[index].bio,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          instructordata[index].date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          instructordata[index].email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.reply),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
