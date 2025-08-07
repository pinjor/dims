import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';

class LoginScreenAdmin extends StatefulWidget {
  const LoginScreenAdmin({super.key});
  static const String name = '/login-screen';

  @override
  State<LoginScreenAdmin> createState() => LoginScreenAdminState();
}

class LoginScreenAdminState extends State<LoginScreenAdmin> {
  final TextEditingController _emailOrMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Navigator.pushReplacementNamed(context, OtpVeificationScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [AppLogo()],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login', style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: 5),
                          Container(
                            height: 6,
                            width: 90,
                            color: appColors.themeColor,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: _emailOrMobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: Text('Email Address*'),
                      hintText: 'Type here',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please give valid Email Address';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      label: Text('Password*'),
                      hintText: 'Type here',
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVeificationScreen(),
                            ),
                          );
                        },
                        child: Text('Forget Password', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}