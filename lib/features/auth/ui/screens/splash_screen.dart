import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  static const String name = '/';
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, EmailVerificationScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              AppLogoWidget(),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
