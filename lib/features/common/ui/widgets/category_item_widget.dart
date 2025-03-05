import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductListScreen.name,
            arguments: 'Electronics');
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appColors.themeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.computer,
              color: appColors.themeColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Electronics',
            style: TextStyle(
              color: appColors.themeColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
