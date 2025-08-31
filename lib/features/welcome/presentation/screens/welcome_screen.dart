import 'package:ecommerce/features/auth/ui/screens/login_screen_admin.dart';
import 'package:ecommerce/features/medicine/presentation/screens/medicine_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/app/disclaimerbanner.dart';
import 'package:ecommerce/features/Prescription/presentation/qr_scan_page.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String name = '/welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isAdminLogin = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAdminToggle(bool value) {
    setState(() {
      _isAdminLogin = value;
    });

    if (_isAdminLogin) {
      // Navigate directly to admin login screen
      Navigator.push(
        context,
        MaterialPageRoute(

          builder: (context) => LoginScreenAdmin(),
        ),
      ).then((_) {
        // Reset toggle when returning
        setState(() {
          _isAdminLogin = false;
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF9FEDCE),
                  Color(0xFF00984A),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60), // Space for top-right toggle

                  // App Logo
                  AppLogo(
                    width: 180,
                    height: 40,
                    boxfit: BoxFit.fitWidth,
                  ),

                  // Welcome Text
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 70, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mobile App Service',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // QR Banner
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRScanPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        'assets/images/Banner.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  // Bottom content
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                    child: Text(
                      '   Keep Track',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      '   We will make it easy to manage \n           your medication routine',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // View Prescription Button
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MedicineListScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Text(
                            'View Medicines',
                            style: TextStyle(
                              color: appColors.themeColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Powered by section
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              'Powered by',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'assets/images/egen_logo.png',
                            width: 70,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Admin/Patient Toggle Switch - Top Right Corner
          Positioned(
            top: 60,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isAdminLogin ? 'Admin' : 'Patient',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Switch(
                    activeColor: appColors.themeColor,
                    value: _isAdminLogin,
                    onChanged: _handleAdminToggle,
                  ),
                ],
              ),
            ),
          ),


          // Disclaimer Banner
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SlideTransition(
              position: _slideAnimation,
              child: DisclaimerBanner(),
            ),
          ),
        ],
      ),
    );
  }
}