import 'package:ecommerce/features/Account/Presentation/screen/account_screen.dart';
import 'package:ecommerce/features/Prescription/presentation/qr_scan_page.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/ehr/presentation/screens/ehr_screen.dart';
import 'package:ecommerce/features/home/presentation/screens/banner_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = '/bottom-nav-screen ';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}






class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  // final MainButtomNavController bottomNavController =
  //     Get.find<MainButtomNavController>();




  final List<Widget> _screens = [
    BannerHomeScreen(),
    QRScanPage(),
    EHRScreen(),
    AccountScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainButtomNavController>(builder: (bottomNavController) {
      return Scaffold(
        body: _screens[bottomNavController.selectedIndex],

        bottomNavigationBar: NavigationBar(
          selectedIndex: bottomNavController.selectedIndex,
          onDestinationSelected: bottomNavController.changeIndex,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.local_pharmacy), label: 'Prescription'),
            NavigationDestination(
                icon: Icon(Icons.medical_services), label: 'EHR'),
            NavigationDestination(
                icon: Icon(Icons.person), label: 'Profile'),


          ],
        ),
      );
    });
  }
}
