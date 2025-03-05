import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:flutter/material.dart';

class CartProductItemWidget extends StatelessWidget {
  const CartProductItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Image.asset(
              assetsPath.shoe_png,
              width: 90,
              height: 90,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Nike Show - AK45394 New Year Deal',
                            maxLines: 1,
                            style: textTheme.bodyLarge?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text('Color : Red'),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Size : XL'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.delete_outline))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$100',
                      style: TextStyle(
                          color: appColors.themeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    ProductQuantityIncDecButton(
                      onChange: (int noOfItem) {},
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
