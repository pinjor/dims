import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:ecommerce/features/product/ui/screens/product_create_review_screen.dart';
import 'package:ecommerce/features/product/ui/widgets/color_picker_widget.dart';
import 'package:ecommerce/features/product/ui/widgets/product_image_carousel_slider.dart';
import 'package:ecommerce/features/product/ui/widgets/size_picker_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product/product-details';

  final int productId;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProductImageCarouselSlider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Nike Shoe A2ERF - New Year Special Deal',
                                    style: textTheme.titleMedium,
                                  ),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Wrap(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            '4.8',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductCreateReviewScreen(),
                                              ),
                                            );
                                          },
                                          child: const Text('Reviews')),
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: appColors.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            ProductQuantityIncDecButton(
                              onChange: (int value) {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Color',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ColorPickerWidget(
                          colors: ['Red', 'Green', 'Yellow', 'Pink', 'Blue'],
                          onColorSelected: (String selectedColor) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Size',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizePickerWidget(
                          sizes: ['S', 'XL', 'L', 'XXL'],
                          onSizeSelected: (String selectedSize) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Description',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                        ''',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildPriceAndAddToCartSection(textTheme)
        ],
      ),
    );
  }

  Container _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appColors.themeColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Price',
                style: textTheme.titleMedium?.copyWith(color: Colors.black87),
              ),
              const Text('\$1000',
                  style: TextStyle(
                    color: appColors.themeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
