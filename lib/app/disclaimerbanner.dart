import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class DisclaimerBanner extends StatefulWidget {
  @override
  _DisclaimerBannerState createState() => _DisclaimerBannerState();
}

class _DisclaimerBannerState extends State<DisclaimerBanner> {
  bool _showBanner = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showBanner) return SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
          BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 4),
          )],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Disclaimer for Popular App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 400,
              child: Padding(
                padding: EdgeInsets.only(right: 8), // Right padding for scrollbar space
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thickness: 2,
                  radius: Radius.circular(2),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            _buildTextSpan('1. General Information\n\n'),
                            WidgetSpan(
                              child: SizedBox(height: 10), // Adjust height as needed
                            ),
                            _buildWidgetSpan('The "Popular App" is designed to assist healthcare professionals and administrators in managing hospital operations. It is not a substitute for professional medical advice, diagnosis, or treatment.\n'),
                            _buildTextSpan('2. No Medical Liability\n\n'),
                        _buildWidgetSpan( ' • The App does not provide medical services or emergency response.\n',
                            ),
                            _buildWidgetSpan(' • Patients should consult qualified healthcare providers for medical concerns.\n'),
                            _buildWidgetSpan(' • The developers are not responsible for any medical decisions made based on the App\'s data.\n'),
                            _buildTextSpan('3. Data Accuracy & Security\n\n'),
                            _buildWidgetSpan(' • While we strive for accuracy, we do not guarantee error-free data processing.\n'),
                            _buildWidgetSpan(' • Users are responsible for verifying critical information.\n'),
                            _buildWidgetSpan(' • The App follows industry-standard security measures, but we cannot guarantee complete protection against breaches.\n'),
                            _buildTextSpan('4. Third-Party Services\n\n'),
                            _buildWidgetSpan(' • The App may integrate with external systems (e.g., labs, pharmacies). We are not liable for their services.\n'),
                            _buildWidgetSpan(' • Links to third-party websites/apps are not under our control.\n'),
                            _buildTextSpan('5. Use at Your Own Risk\n\n'),
                            _buildWidgetSpan(' • The App is provided "as is" without warranties of any kind.\n'),
                            _buildWidgetSpan(' • The developers shall not be liable for any damages arising from App usage.\n'),
                            _buildTextSpan('6. Compliance & Regulations\n\n'),
                            _buildWidgetSpan(' • Users must comply with local healthcare laws (e.g., HIPAA, GDPR) when handling patient data.\n'),
                            _buildWidgetSpan(' • Unauthorized use or misuse of the App is prohibited.\n'),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showBanner = false;
                });
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _buildTextSpan(data) {
    return TextSpan(
                            text: data,
                            style: TextStyle(fontWeight: FontWeight.bold),

                          );
  }

  WidgetSpan _buildWidgetSpan(data) {
    return WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                data,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
  }
}