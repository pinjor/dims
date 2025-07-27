import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/manage_address/presentation/screens/add_new_address.dart';
import 'package:flutter/material.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  int? selectedAddressIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Address',style:
        TextStyle(fontSize: 20,color: appColors.themeColor),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildAddressCard(
                index: 0,
                title: 'Home Address',
                icon: Icons.home,
                name: 'Rahim',
                phone: '+8801825556666',
                address: 'House # 38, Road # 11, Block # A\nBashundhara R/A, Dhaka',
              ),
              const SizedBox(height: 24),
              _buildAddressCard(
                index: 1,
                title: 'Office Address ',
                icon: Icons.work,
                name: 'Rahim',
                phone: '+8801825556666',
                address: 'House # 38, Road # 11, Block # A\nBashundhara R/A, Dhaka',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddShippingAddressScreen()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Add New Address',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required int index,
    required String title,
    required IconData icon,
    String? name,
    required String phone,
    required String address,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Icon on left side
            Icon(icon, size: 32, color: Colors.grey[600]),
            const SizedBox(width: 12),

            // Address details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (name != null) Text(name),
                  Text(phone),
                  Text(address.replaceAll('\n', ', ')),
                ],
              ),
            ),

            // Selection circle on right side
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedAddressIndex = selectedAddressIndex == index ? null : index;
                });
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedAddressIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                child: selectedAddressIndex == index
                    ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}