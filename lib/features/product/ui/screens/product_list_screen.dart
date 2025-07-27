import 'package:ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryName});

  static const String name = '/product/product-list-by-category';

  final String categoryName;
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}
   
class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
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
    );
  }
}
