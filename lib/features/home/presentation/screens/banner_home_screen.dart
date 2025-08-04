import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/Account/Presentation/screen/profile_screen.dart';
import 'package:ecommerce/features/Prescription/presentation/qr_scan_page.dart';
import 'package:ecommerce/features/ehr/presentation/screens/ehr_screen.dart';
import 'package:flutter/material.dart';

class BannerHomeScreen extends StatelessWidget {
  const BannerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppLogo(
                width: 180,
                height: 100,
                boxfit: BoxFit.fitWidth,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/images/view-profile.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
                  height: 170,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/images/view_pres.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EHRScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 170,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/images/view_ehr.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
