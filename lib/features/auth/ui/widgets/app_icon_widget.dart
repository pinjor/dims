import 'package:ecommerce/app/assets_path.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.width,
    this.height,
    this.boxfit,
  });

  final double? width;
  final double? height;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      //'assets/images/logo.svg',
      assetsPath.app_logo_svg,
      width: width ?? 220,
      height: height ?? 220,
      fit: boxfit ?? BoxFit.scaleDown,
    );
  }
}
