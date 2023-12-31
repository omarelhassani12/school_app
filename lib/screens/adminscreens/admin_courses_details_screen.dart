import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../utils/colors.dart';
import '../../widgets/link_button.dart';
import 'courses/coursevideo_page.dart';
import 'courses/description_page.dart';
import 'courses/goal_page.dart';

class AdminCoursesDetailsScreen extends StatefulWidget {
  final Course course;

  const AdminCoursesDetailsScreen({Key? key, required this.course})
      : super(key: key);

  @override
  AdminCoursesDetailsScreenState createState() =>
      AdminCoursesDetailsScreenState();
}

class AdminCoursesDetailsScreenState extends State<AdminCoursesDetailsScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Details',
          style: TextStyle(
            color: ColorsApp.mainClr,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsApp.whiteClr,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorsApp.mainClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.course.imageUrl,
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 16.0),
                Text(
                  widget.course.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Instructor: ${widget.course.instructor}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorsApp.mainClr,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildButton('Description', 0),
                  const SizedBox(width: 10.0),
                  _buildButton('Course Goal', 1),
                  const SizedBox(width: 10.0),
                  _buildButton('Course Video', 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentPageIndex,
              children: [
                _buildPage(
                  DescriptionPage(
                    description: widget.course.description,
                    duration: widget.course.duration,
                  ),
                ),
                _buildPage(CourseGoalPage(goals: widget.course.goals)),
                _buildPage(CourseVideoPage(
                  videoUrl: widget.course.videoUrl,
                  videos: '',
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Widget page) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: page,
      ),
    );
  }

  Widget _buildButton(String title, int index) {
    final bool isSelected = _currentPageIndex == index;

    return LinkButton(
      title: title,
      isSelected: isSelected,
      onPressed: () {
        setState(() {
          _currentPageIndex = index;
        });
      },
    );
  }
}
