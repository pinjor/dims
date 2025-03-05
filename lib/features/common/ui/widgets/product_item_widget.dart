import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/product/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name, arguments: 1);
      },
      child: SizedBox(
        width: 140,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appColors.themeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  assetsPath.shoe_png,
                  width: 140,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'New Year Special Shoe 30',
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$100',
                          style: TextStyle(
                            color: appColors.themeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(
                              Icons.star_outlined,
                              color: Colors.amber,
                              size: 18,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: appColors.themeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: appColors.themeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
