import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [
              _buildCategoryCard(
                imagePath: 'assets/images/download.jpg',
                label: 'Medicine Product',
                color: Colors.blue[100]!,
                onTap: () {},
              ),
              SizedBox(width: 12),
              _buildCategoryCard(
                imagePath: 'assets/images/med.png',
                label: 'Healthcare Device',
                color: Colors.green[100]!,
                onTap: () {},
              ),
              SizedBox(width: 12),
              _buildCategoryCard(
                imagePath: 'assets/images/download.jpg',
                label: 'Baby Care Product',
                color: Colors.pink[100]!,
                onTap: () {},
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String imagePath,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  height: 10,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}