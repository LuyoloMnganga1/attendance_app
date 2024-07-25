import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            AppBarSliver(
              title: 'Help',
              maxExtent: 100,
              onPressBack: () {
                Navigator.pop(context);
              },
              bottomChild: Text(
                'Help',
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
                  'Help and Support',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Welcome to the ICT Choice Attendance App support page! We\'re here to assist you with any questions or issues you may encounter while using our app. Our goal is to provide you with a seamless experience, and we are committed to resolving any problems as quickly as possible.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'How to Get Help',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'If you need assistance, please follow these steps:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '1. User Guide: Access our comprehensive user guide for detailed instructions on how to use the app\'s features. However, our app is easy to use.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '2. Contact Support: If you cannot find the answer to your question or need further assistance, you can contact our support team.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Logging a Support Ticket',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'For any technical issues, bugs, or general inquiries, you can log a support ticket by sending an email to our support team. Please include the following information in your email to help us address your issue more effectively:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '• Your name and contact information',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• A detailed description of the issue you are experiencing',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• Any relevant screenshots or error messages',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• Steps to reproduce the issue, if applicable',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email your support ticket to: support@ictchoice.com',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Our support team is available to help you and will respond to your inquiry as soon as possible.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Thank you for using ICT Choice Attendance App. We appreciate your feedback and are here to ensure you have the best possible experience.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
