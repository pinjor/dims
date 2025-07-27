import 'package:ecommerce/app/assets_path.dart';
import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
  const AppLogo({
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
      assetsPath.nav_logo_svg,
      width: width ?? 230,
      height: height ?? 100,
      fit: boxfit ?? BoxFit.fitWidth,
    );
  }
}
