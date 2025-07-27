import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({super.key});

  @override
  State<AddShippingAddressScreen> createState() => _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _addressType = 'Home';
  bool _makeDefault = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shipping Address',style:
        TextStyle(fontSize: 20,color: appColors.themeColor),),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Field
              const Text(
                'Your Full Name *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Abdur Rahim',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Contact Field
              const Text(
                'Contact *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  hintText: '+8801******',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
             // const SizedBox(height: 16),

              // // District Field
              // const Text(
              //   'District *',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(
              //     hintText: 'Select',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              //   items: ['Dhaka', 'Chittagong', 'Sylhet', 'Khulna']
              //       .map((district) => DropdownMenuItem(
              //     value: district,
              //     child: Text(district),
              //   ))
              //       .toList(),
              //   onChanged: (value) {
              //     _districtController.text = value ?? '';
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a district';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 16),

              // City Field
              const Text(
                'City *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Select City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ['Dhaka', 'Chittagong', 'Sylhet', 'Khulna','Rangpur','Rajshahi','Dinajpur','Mymensingh']
                    .map((city) => DropdownMenuItem(
                  value: city,
                  child: Text(city),
                ))
                    .toList(),
                onChanged: (value) {
                  _cityController.text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Area Field
              const Text(
                'Area *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Select Area',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ['Bashundhara R/A', 'Dhanmondi', 'Mirpur', 'Uttara']
                    .map((area) => DropdownMenuItem(
                  value: area,
                  child: Text(area),
                ))
                    .toList(),
                onChanged: (value) {
                  _areaController.text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an area';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address Field
              const Text(
                'Full Address Details*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'House # 38, Road # 11, Block # A',
                  labelText: 'Address Details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Address Type
              const Text(
                'Address Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAddressTypeButton('Home'),
                  _buildAddressTypeButton('Office'),
                  _buildAddressTypeButton('Others'),
                ],
              ),
              const SizedBox(height: 24),

              // Make Default Address
              Row(
                children: [
                  Checkbox(
                    value: _makeDefault,
                    onChanged: (value) {
                      setState(() {
                        _makeDefault = value ?? false;
                      });
                    },
                  ),
                  const Text('Make default address'),
                ],
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the address
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Address',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTypeButton(String type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: _addressType == type
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            side: BorderSide(
              color: _addressType == type
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
          onPressed: () {
            setState(() {
              _addressType = type;
            });
          },
          child: Text(type),
        ),
      ),
    );
  }
}