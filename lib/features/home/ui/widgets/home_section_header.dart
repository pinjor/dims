import 'package:flutter/material.dart';

class HomeScetionHeader extends StatelessWidget {
  const HomeScetionHeader({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text('See all'),
        )
      ],
    );
  }
}
