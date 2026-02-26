import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

// ignore: must_be_immutable
class CustomListView extends StatelessWidget {
  CustomListView({super.key});
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
      child: ListView.builder(
        itemCount: instructordata.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(child: Icon(Icons.person)),
                      SizedBox(width: 8.w),
                      Text(
                        instructordata[index].name,
                        style: context.textTheme.labelMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      instructordata[index].bio,
                      style: context.textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      instructordata[index].date,
                      style: context.textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      instructordata[index].email,
                      style: context.textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.reply),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
