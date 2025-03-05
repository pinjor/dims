import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageCarouselSlider extends StatefulWidget {
  const ProductImageCarouselSlider({
    super.key,
  });

  @override
  State<ProductImageCarouselSlider> createState() =>
      _ProductImageCarouselSliderState();
}

class _ProductImageCarouselSliderState
    extends State<ProductImageCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 220.0,
              viewportFraction: 0.98,
              onPageChanged: (currentIndex, reason) {
                _selectedIndex.value = currentIndex;
              }),
          items: [1, 2, 3, 4].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  // child: Text(
                  //   'Happy Newyear Deal',
                  //   style: TextStyle(fontSize: 16.0),
                  // ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Container(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: value == i
                                ? appColors.themeColor
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                      )
                  ],
                );
              }),
        )
      ],
    );
  }
}
