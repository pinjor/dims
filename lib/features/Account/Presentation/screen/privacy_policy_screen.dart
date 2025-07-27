import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',style:
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
              '1. Information We Collect',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We collect information to provide better services to all our users. The information we collect includes:\n\n'
                  '- Personal information you provide (name, email, phone number)\n'
                  '- Device information (model, operating system)\n'
                  '- Usage data (how you use our app)\n'
                  '- Location data (if you enable location services)',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '2. How We Use Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We use the information we collect to:\n\n'
                  '- Provide, maintain, and improve our services\n'
                  '- Develop new features and functionality\n'
                  '- Provide customer support\n'
                  '- Send important notices and updates\n'
                  '- Detect and prevent fraud and abuse',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '3. Information Sharing',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We do not share personal information with companies, organizations, or individuals outside of our company except in the following cases:\n\n'
                  '- With your consent\n'
                  '- For external processing by our trusted service providers\n'
                  '- For legal reasons (to comply with laws or respond to legal requests)',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '4. Data Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We implement appropriate security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information. These include:\n\n'
                  '- Encryption of data in transit\n'
                  '- Secure server infrastructure\n'
                  '- Regular security audits',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '5. Your Rights',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have the right to:\n\n'
                  '- Access the personal information we hold about you\n'
                  '- Request correction of inaccurate information\n'
                  '- Request deletion of your personal data\n'
                  '- Object to certain processing activities\n'
                  '- Withdraw consent where applicable',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '6. Changes to This Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '7. Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at:\n\n'
                  'Email: privacy@yourapp.com\n'
                  'Address: Your Company Address, City, Country',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}