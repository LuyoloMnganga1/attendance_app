import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AboutTheApp extends StatefulWidget {
  const AboutTheApp({super.key});

  @override
  State<AboutTheApp> createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            AppBarSliver(
              title: 'About the App',
              maxExtent: 100,
              onPressBack: () {
                Navigator.pop(context);
              },
              bottomChild: Text(
                'About the App',
                style: blackTextStyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          body:Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                Text(
                  'Background Story of the App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'In many organizations, schools, and institutions, attendance tracking has been a crucial part of daily operations. Traditionally, this process involved manually recording attendance in physical books. This method, while straightforward, came with numerous challenges:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  '1. Time-Consuming: Manually marking attendance for each individual every day took considerable time, especially in larger groups.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '2. Human Errors: Mistakes were common, whether it was missing entries, marking the wrong person, or misplacing the attendance book.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '3. Data Management: Keeping track of historical attendance data was cumbersome, with stacks of books occupying space and making it difficult to retrieve specific records.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '4. Lack of Real-Time Insights: Analyzing attendance patterns and generating reports required manual effort and often led to delayed decision-making.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Recognizing these challenges, our team embarked on a mission to create a solution that would not only streamline the attendance tracking process but also enhance its accuracy and efficiency. Thus, our Digital Attendance App was born.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'In the era of digital transformation, we identified a significant inefficiency in the manual attendance tracking systems used by many organizations. These systems were not only time-consuming but also prone to errors and difficult to manage. Our app was designed to address these issues by providing a seamless and automated way to capture and manage attendance records, eliminating the need for physical books and reducing the risk of errors.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'The traditional method of recording attendance in books posed several challenges, from human errors to time inefficiency. Inspired by the need for a more reliable and efficient system, we developed our app to digitize attendance tracking. This shift not only simplified the process but also provided instant access to attendance data, facilitating better data management and decision-making.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Our journey began with the realization that manual attendance books were no longer sufficient in today\'s fast-paced environment. The cumbersome process of marking attendance manually led to frequent errors and difficulties in data retrieval. Our app emerged as a solution, offering an intuitive digital platform that transformed the way attendance was recorded and managed, ensuring accuracy and efficiency.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
