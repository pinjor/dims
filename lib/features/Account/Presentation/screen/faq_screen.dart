import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions',style:
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

            // Account Questions
            _buildFAQSection(
              title: 'Account & Profile',
              questions: [
                {
                  'question': 'How do I create an account?',
                  'answer': 'Tap on "Sign Up" from the login screen and follow the instructions to register with your email or phone number.'
                },
                {
                  'question': 'I forgot my password. What should I do?',
                  'answer': 'On the login screen, tap "Forgot Password" and follow the instructions to reset your password via email or SMS.'
                },
                {
                  'question': 'How do I update my profile information?',
                  'answer': 'Go to your Account screen, tap "View Profile", then edit your details and save changes.'
                },
              ],
            ),

            // Order Questions
            _buildFAQSection(
              title: 'Orders & Payments',
              questions: [
                {
                  'question': 'How do I place an order?',
                  'answer': 'Browse products, add items to your cart, proceed to checkout, select payment method, and confirm your order.'
                },
                {
                  'question': 'What payment methods do you accept?',
                  'answer': 'We accept credit/debit cards, mobile banking, and cash on delivery (where available).'
                },
                {
                  'question': 'How can I track my order?',
                  'answer': 'Go to "My Orders" in the app to see real-time tracking information for your current orders.'
                },
                {
                  'question': 'Why was my payment declined?',
                  'answer': 'This could be due to insufficient funds, incorrect card details, or bank restrictions. Please verify your payment information or try another method.'
                },
              ],
            ),

            // Delivery Questions
            _buildFAQSection(
              title: 'Delivery & Shipping',
              questions: [
                {
                  'question': 'What are your delivery hours?',
                  'answer': 'We deliver daily from 9AM to 9PM, including weekends and holidays.'
                },
                {
                  'question': 'How long does delivery take?',
                  'answer': 'Standard delivery takes 2-3 business days. Express delivery is available for same-day or next-day service in some areas.'
                },
                {
                  'question': 'Do you deliver internationally?',
                  'answer': 'Currently we only deliver within [your country]. We plan to expand internationally soon.'
                },
              ],
            ),

            // Returns & Refunds
            _buildFAQSection(
              title: 'Returns & Refunds',
              questions: [
                {
                  'question': 'How do I return a product?',
                  'answer': 'Contact customer service within 30 days of delivery to initiate a return. Please have your order number ready.'
                },
                {
                  'question': 'How long do refunds take?',
                  'answer': 'Refunds are processed within 5-7 business days after we receive your returned item.'
                },
              ],
            ),

            // Technical Issues
            _buildFAQSection(
              title: 'Technical Support',
              questions: [
                {
                  'question': 'The app keeps crashing. What should I do?',
                  'answer': 'Try updating to the latest version, clearing app cache, or reinstalling the app. If issues persist, contact our support team.'
                },
                {
                  'question': 'I\'m not receiving verification codes. What can I do?',
                  'answer': 'Check your spam folder, ensure your phone has signal, or try requesting the code again after 2 minutes.'
                },
              ],
            ),

            // Contact Information
            SizedBox(height: 20),
            Text(
              'Still need help?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Contact our customer support team:\n\n'
                  'Email: support@yourapp.com\n'
                  'Phone: +1 (555) 123-4567\n'
                  'Live Chat: Available in-app 24/7\n'
                  'Business Hours: Mon-Sun, 8AM-10PM',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection({required String title, required List<Map<String, String>> questions}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        ...questions.map((qa) => _buildFAQItem(
          question: qa['question']!,
          answer: qa['answer']!,
        )).toList(),
      ],
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            answer,
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}