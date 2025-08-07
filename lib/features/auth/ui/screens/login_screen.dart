import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  static const String name = '/login-screen';
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrMobileController =
  TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isAdminLogin = false;

  // Future<void> _loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     FocusScope.of(context).unfocus();
  //
  //     final mobileOrEmail = _emailOrMobileController.text.trim();
  //     final password = _passwordController.text.trim();
  //
  //     ref
  //         .read(authControllerProvider.notifier)
  //         .login(
  //       mobileOrEmail: mobileOrEmail,
  //       password: password,
  //       isAdmin: _isAdminLogin,
  //     );
  //     // Navigation handled by GoRouter redirect method automatically
  //   }
  // }

  // @override
  // void initState() {
  //   // _emailOrMobileController.text = '01712345678';
  //   // _passwordController.text = 'Arp@12345';
  //   //super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Align(
                  //   // alignment: Alignment.topRight,
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.center
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         _isAdminLogin ? 'Admin' : 'Patient',
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //       ),
                  //       Switch(
                  //         activeColor: appColors.themeColor,
                  //         value: _isAdminLogin,
                  //         onChanged: (bool value) {
                  //           setState(() {
                  //             _isAdminLogin = value;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 60,),
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
                            'Login',
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
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: _emailOrMobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: Text(_isAdminLogin ? 'Email*' : 'Phone Number*'),
                      hintText: 'Type here',
                    ),
                    keyboardType:
                    _isAdminLogin
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return _isAdminLogin ? 'Please give valid Email' : 'Please give valid Phone Number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please give valid Password';
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
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          //! maybe this should be changed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVeificationScreen(),
                            ),
                          );
                          // context.push(RoutePath.enterEmailScreenPath); // not working
                        },
                        child: Text(
                          'Forget Password ',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // if (authState.isLoading)
                  //   CircularProgressIndicator()
                  // else
                    ElevatedButton(
                      onPressed:  () {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => MainBottomNavScreen()));
    //if (_formKey.currentState!.validate()) {}
    },
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),

                    ),
                  // if (authState.error != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 8.0),
                  //     child: Text(
                  //       authState.error!,
                  //       style: TextStyle(color: Colors.red),
                  //     ),
                  //   ),

                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text('Don`t have an account?'),
                        TextButton(
                          onPressed: () {
                            // _launchUrl(_url);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteProfileScreen(),
                              ),
                            );
                          },
                          child: Text('Create Account'),
                        ),
                      ],
                    ),
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