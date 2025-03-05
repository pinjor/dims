import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_icon_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String name = '/email-verification';
  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                Text('Welcome Back',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'Please Enter Your Email Address',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email address';
                    }
                    if (EmailValidator.validate(value!) == false) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, OtpVeificationScreen.name);
                    //if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
