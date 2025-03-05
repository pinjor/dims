import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('WishList'),
          leading: IconButton(
            onPressed: _onPop,
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
            crossAxisSpacing: 2,
            mainAxisSpacing: 4,
          ),
          itemCount: 20,
          itemBuilder: (context, index) => const ProductItemWidget(),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainButtomNavController>().backToHome();
  }
}
