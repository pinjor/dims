import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget(
      {super.key, required this.sizes, required this.onSizeSelected});

  final List<String> sizes;
  final Function(String) onSizeSelected;

  @override
  State<SizePickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<SizePickerWidget> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _getSizeItems(),
      ),
    );
  }

  List<Widget> _getSizeItems() {
    List<Widget> colorItemWidgetList = [];
    for (String size in widget.sizes) {
      Widget item = getSizeItemWidget(
        name: size,
        onTap: () {
          _selectedSize = size;
          widget.onSizeSelected(_selectedSize!);
          setState(() {});
        },
        isSeleted: _selectedSize == size,
      );
      colorItemWidgetList.add(item);
    }
    return colorItemWidgetList;
  }

  Widget getSizeItemWidget(
      {required String name,
      required VoidCallback onTap,
      required bool isSeleted}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            border: Border.all(),
            color: isSeleted ? appColors.themeColor : Colors.transparent),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(color: isSeleted ? Colors.white : null),
        ),
      ),
    );
  }
}
