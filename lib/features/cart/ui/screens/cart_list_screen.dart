import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
            onPressed: _onPop,
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CartProductItemWidget();
                  }),
            ),
            _buildPriceAndAddToCartSection(textTheme),
          ],
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainButtomNavController>().backToHome();
  }

  Widget _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: appColors.themeColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Total Price',
                style: textTheme.titleMedium?.copyWith(color: Colors.black87),
              ),
              const Text(
                '\$10000.00',
                style: TextStyle(
                  color: appColors.themeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}

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
