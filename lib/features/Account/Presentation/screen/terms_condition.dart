import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions',style:
          TextStyle(fontSize: 20,color: appColors.themeColor),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: January 1, 2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to our application. These terms and conditions outline the rules and regulations for the use of our app.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '2. Intellectual Property Rights',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Other than the content you own, under these Terms, we own all the intellectual property rights and materials contained in this application.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '3. Restrictions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You are specifically restricted from all of the following:\n'
                  '- Publishing any app material in any other media\n'
                  '- Selling, sublicensing and/or otherwise commercializing any app material\n'
                  '- Using this app in any way that is or may be damaging to the app\n'
                  '- Using this app in any way that impacts user access to this app',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '4. Your Content',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'In these terms and conditions, "Your Content" shall mean any audio, video, text, images or other material you choose to display on this application.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '5. Changes to Terms',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We reserve the right to modify these terms at any time. By continuing to use the app after any revisions become effective, you agree to be bound by the revised terms.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}