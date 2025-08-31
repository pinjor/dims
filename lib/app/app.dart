import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/reset_password_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:ecommerce/features/category/ui/screens/category_list_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce/features/home/presentation/screens/banner_home_screen.dart';
import 'package:ecommerce/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_create_review_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_details_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_review_list.dart';
import 'package:ecommerce/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:ecommerce/features/admin/presentation/screens/admin_login_screen.dart';
import 'package:ecommerce/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:ecommerce/features/admin/presentation/screens/medicine_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class craftybay extends StatelessWidget {
  const craftybay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: AppThemeData.lightThemeData,
      initialBinding: ControllerBinder(),

      //darkTheme: ThemeData(),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == splash_screen.name) {
          widget = const splash_screen();
        }
        else if(settings.name == WelcomeScreen.name){
          widget = const WelcomeScreen();
        }
        else if (settings.name == EmailVerificationScreen.name) {
          widget = const EmailVerificationScreen();}
        else if (settings.name == LoginScreen.name) {
          widget = const LoginScreen();
        }
        else if (settings.name == BannerHomeScreen.name) {
          widget = const BannerHomeScreen();
        }
         else if (settings.name == OtpVeificationScreen.name) {
          widget = const OtpVeificationScreen();
        } else if (settings.name == CompleteProfileScreen.name) {
          widget = const CompleteProfileScreen();
        } else if (settings.name == HomeScreen.name) {
          widget = const HomeScreen();
        }else if (settings.name == ResetPasswordScreen.name) {
          widget = const ResetPasswordScreen(phoneNumber: '', otp: '',);
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        } else if (settings.name == CategoryListScreen.name) {
          widget = const CategoryListScreen();
        } else if (settings.name == ProductListScreen.name) {
          String name = settings.arguments as String;
          widget = ProductListScreen(
            categoryName: name,
          );
        } else if (settings.name == ProductDetailsScreen.name) {
          int productId = settings.arguments as int;
          widget = ProductDetailsScreen(
            productId: productId,
          );
        } else if (settings.name == ProductCreateReviewScreen.name) {
          widget = const ProductCreateReviewScreen();
        } else if (settings.name == ProductReviewList.name) {
          widget = const ProductReviewList();
        } else if (settings.name == '/admin/login') {
          widget = const AdminLoginScreen();
        } else if (settings.name == '/admin/dashboard') {
          widget = const AdminDashboardScreen();
        } else if (settings.name == '/admin/medicine-form') {
          widget = const MedicineFormScreen();
        }

        return MaterialPageRoute(builder: (ctx) {
          return widget;
        });

        //'/': (context) => splash_screen(),
        // EmailVerificationScreen.name: (context) => EmailVerificationScreen(),
        // OtpVeificationScreen.name: (context) => OtpVeificationScreen(),
        // CompleteProfileScreen.name: (context) => CompleteProfileScreen(),
        // HomeScreen.name: (context) => HomeScreen(),
        // MainBottomNavScreen.name: (context) => MainBottomNavScreen(),
        // CategoryListScreen.name: (context) => CategoryListScreen(),
        // ProductListScreen.name: (context) => ProductListScreen(
        //       categoryName: '',
        //     ),
      },
    );
  }
}
