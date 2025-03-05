import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
  });

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 180.0,
              viewportFraction: 0.98,
              onPageChanged: (currentIndex, reason) {
                _selectedIndex.value = currentIndex;
              }),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      color: appColors.themeColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Happy Newyear Deal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 8,
        ),
        ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: value == i
                              ? appColors.themeColor
                              : Colors.transparent,
                          border: Border.all(color: Colors.grey)),
                    )
                ],
              );
            })
      ],
    );
  }
}
