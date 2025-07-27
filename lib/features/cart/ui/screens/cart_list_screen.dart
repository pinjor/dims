import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:ecommerce/features/payment/presentation/payment_screen/dart/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  String selectedDeliveryOption = 'Home Delivery'; // 'Pickup' or 'Home Delivery'

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
            onPressed: () {
              _onPop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainBottomNavScreen()));
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Column(
          children: [
            // Current time display
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            //   child: Align(
            //     alignment: Alignment.centerRight,
            //     child: Text(
            //       '10.10 AM',
            //       style: textTheme.bodySmall?.copyWith(color: Colors.grey),
            //     ),
            //   ),
            // ),

            Expanded(
              child: ListView(
                children: [
                  // Your existing product list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CartProductItemWidget();
                    },
                  ),

                  // Delivery options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Delivery Option', style: textTheme.titleSmall),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildDeliveryOption('Pickup', '\$0.00'),
                                _buildDeliveryOption('Home Delivery', '\$50.00'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Shipping address
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping Address', style: textTheme.titleSmall,),
                            TextButton(
                              onPressed: () {
                                // Handle address change
                              },
                              child: Text('Change', style: TextStyle(color: appColors.themeColor)),
                            )],
                            ),
                            SizedBox(height: 8),
                            Text('Rahim', style: textTheme.bodyLarge),
                            Text('+8801825556666', style: textTheme.bodyLarge),
                            Text('H# 38, R# 11, Block # A Bashundhara', style: textTheme.bodyLarge),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Order note
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Note', style: textTheme.titleSmall),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Add any special instructions...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Price summary and checkout
            _buildPriceSummaryAndCheckout(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption(String option, String price) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDeliveryOption = option;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: selectedDeliveryOption == option
                ? appColors.themeColor.withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selectedDeliveryOption == option
                  ? appColors.themeColor
                  : Colors.transparent,
            ),
          ),
          child: Column(
            children: [
              Text(option, style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text(price, style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSummaryAndCheckout(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPriceRow('Sub-Total (MRP)', '\$105.00'),
          _buildPriceRow('Discount', '-\$5.00'),
          _buildPriceRow('Rounding Off', '\$0.00'),
          Divider(height: 24),
          _buildPriceRow('Total', '\$100.00', isTotal: true),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSuccessScreen(),
                    ),
                  );

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: appColors.themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Make Payment', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            color: Colors.grey[700],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          )),
          Text(value, style: TextStyle(
            color: isTotal ? appColors.themeColor : Colors.black,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          )),
        ],
      ),
    );
  }

  void _onPop() {
    Get.find<MainButtomNavController>().backToHome();
  }
}

// Your existing CartProductItemWidget remains unchanged
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
          width: 80,
          height: 80,
          fit: BoxFit.scaleDown,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
          Row(
          children: [
          Expanded(
          child: Column(
          children: [
          Text(
          'Paracetamol + Tramadol Hydrochloride',
            maxLines: 1,
            style: textTheme.bodyLarge?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text('Color : Red'),
              SizedBox(width: 8),
              Text('units  : 500mg'),
            ],
          ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete_outline)
      )],
      ),
      SizedBox(height: 8),
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
    ),
    ),
    ],
    ),
    ),
    );
  }
}