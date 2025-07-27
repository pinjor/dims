import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ReturnPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Policy',style:
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

            // Return Eligibility
            Text(
              '1. Return Eligibility',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You may return most new, unopened items within 30 days of delivery for a full refund. To be eligible for a return:\n\n'
                  '- Item must be unused and in its original condition\n'
                  '- Original packaging must be intact\n'
                  '- Proof of purchase is required\n'
                  '- Some products are non-returnable (e.g., perishables, personalized items)',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),

            // Return Process
            Text(
              '2. Return Process',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'To initiate a return:\n\n'
                  '1. Contact our customer service within 30 days of delivery\n'
                  '2. Provide your order number and reason for return\n'
                  '3. We will provide return instructions\n'
                  '4. Pack the item securely in its original packaging\n'
                  '5. Ship the item back to us using the provided return label',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),

            // Refunds
            Text(
              '3. Refunds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Refunds will be processed within 5-7 business days after we receive your return\n'
                  '- Your refund will be credited to your original payment method\n'
                  '- Shipping costs are non-refundable\n'
                  '- For defective or incorrect items, we will cover return shipping costs',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),

            // Exchanges
            Text(
              '4. Exchanges',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We only replace items if they are defective or damaged. If you need to exchange an item:\n\n'
                  '- Contact us with your order details\n'
                  '- Return the original item following our return process\n'
                  '- Once received, we will ship the replacement item',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),

            // Non-Returnable Items
            Text(
              '5. Non-Returnable Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Certain items cannot be returned:\n\n'
                  '- Perishable goods (food, flowers, etc.)\n'
                  '- Personalized or custom-made products\n'
                  '- Digital products (software, ebooks)\n'
                  '- Intimate apparel for hygiene reasons',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),

            // Contact Information
            Text(
              '6. Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'For any questions about our return policy:\n\n'
                  'Email: returns@yourapp.com\n'
                  'Phone: +1 (555) 123-4567\n'
                  'Business Hours: Mon-Fri, 9AM-5PM',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}