import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static const String name = '/category-list-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category List'),
          leading: IconButton(
            onPressed: () => _onPop(),
            icon: Icon(Icons.keyboard_arrow_left_outlined),
          ),
        ),
        body: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return FittedBox(child: const CategoryItemWidget());
          },
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainButtomNavController>().backToHome();
  }
}
