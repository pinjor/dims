import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.otp,
  });

  final String phoneNumber;
  final String otp;

  static String name='/reset-password';

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Track password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // void _setNewPassword() {
  //   if (!_formKey.currentState!.validate()) return;
  //
  //   final password = _passwordController.text;
  //
  //   ref
  //       .read(authControllerProvider.notifier)
  //       .resetPassword(
  //     context,
  //     password: password,
  //     email: widget.email,
  //     otp: widget.otp,
  //   );
  // }

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
              children: [
                SizedBox(height: 15,),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    AppLogo(),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Password',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 6, // Height of the underline
                          width: 90, // Width of the underline (adjust as needed)
                          color: appColors.themeColor, // Color of the underline
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('Password'),
                    hintText: 'Type here',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isPasswordVisible, // Toggle obscure text
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please give valid Password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text('Confirm Password'),
                    hintText: 'Type here',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),

                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText:
                  !_isConfirmPasswordVisible, // Toggle obscure text
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> MainBottomNavScreen()));},
                  child: Text('Confirm', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}