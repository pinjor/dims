import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVeificationScreen extends StatefulWidget {
  const OtpVeificationScreen({super.key});

  static const String name = '/otp-verification';
  @override
  State<OtpVeificationScreen> createState() => _OtpVeificationScreenState();
}

class _OtpVeificationScreenState extends State<OtpVeificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpTimerButtonController controller = OtpTimerButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                AppLogoWidget(),
                SizedBox(
                  height: 20,
                ),
                Text('Enter OTP Code',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'A 4 Digit OTP Code has been Sent',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    //fieldHeight: 50,
                    // fieldWidth: 40,
                    activeFillColor: appColors.themeColor,
                    selectedFillColor: appColors.themeColor,
                    inactiveColor: appColors.themeColor,
                    selectedColor: appColors.themeColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  //enableActiveFill: true,
                  appContext: context,
                  controller: _otpTEController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    //if (_formKey.currentState!.validate()) {}
                    Navigator.pushNamed(context, CompleteProfileScreen.name);
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RichText(
                  text: TextSpan(
                      text: 'This code will be expired in ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: '120s',
                          style: TextStyle(color: appColors.themeColor),
                        ),
                      ]),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text('Resend Code'),
                // ),
                OtpTimerButton(
                  controller: controller,
                  onPressed: () {},
                  text: Text('Resend Code'),
                  duration: 120,
                  buttonType: ButtonType.text_button,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
