import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/ui/screens/product_create_review_screen.dart';
import 'package:flutter/material.dart';

class ProductReviewList extends StatefulWidget {
  const ProductReviewList({super.key});

  static const String name = '/product/reviewlist';
  @override
  State<ProductReviewList> createState() => _ProductReviewListState();
}

class _ProductReviewListState extends State<ProductReviewList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 10,
            )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.perm_identity_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Rabbil Hasan',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '''Redundancy happens when the repetition of a word or idea does not add anything to the previous usage; it just restates what has already been said, takes up space, and gets in the way without adding meaning. Computer scientist Donald ''',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.perm_identity_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Rabbil Hasan',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '''Redundancy happens when the repetition of a word or idea does not add anything to the previous usage; it just restates what has already been said, takes up space, and gets in the way without adding meaning. Computer scientist Donald ''',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.perm_identity_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Rabbil Hasan',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '''Redundancy happens when the repetition of a word or idea does not add anything to the previous usage; it just restates what has already been said, takes up space, and gets in the way without adding meaning. Computer scientist Donald ''',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            _buildPriceAndAddToCartSection(textTheme),
          ],
        ),
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
                'Reviews (1000)',
                style: textTheme.titleMedium?.copyWith(color: Colors.black87),
              ),
              // const Text('\$1000',
              //     style: TextStyle(
              //       color: appColors.themeColor,
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600,
              //     )),
            ],
          ),
          SizedBox(
            width: 100,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductCreateReviewScreen()),
                );
              },
              icon: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                backgroundColor: appColors.themeColor, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
