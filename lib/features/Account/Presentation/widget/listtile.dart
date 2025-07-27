import 'package:ecommerce/app/app_colors.dart' show appColors;
import 'package:flutter/material.dart';

Widget buildListTile({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
  bool isLogout = false,
}) {
  return ListTile(
    onTap: onTap,
    leading: Icon(
      icon,
      color: isLogout ? Colors.red : appColors.themeColor,
      size: 24,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: isLogout ? Colors.red : Colors.black,
      ),
    ),
    trailing: Icon(
      Icons.chevron_right,
      color: Colors.grey,
    ),
  );
}

