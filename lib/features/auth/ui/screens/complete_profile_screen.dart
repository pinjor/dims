import 'package:ecommerce/features/auth/ui/widgets/app_icon_widget.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  static const String name = '/complete-profile';
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const AppLogoWidget(
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Complete Profile',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                'Get started with us with your details',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              _buildForm(),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainBottomNavScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Complete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(hintText: 'First Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid First Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(hintText: 'Last Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Last Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _mobileTEController,
            decoration: const InputDecoration(hintText: 'Mobile'),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 11,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your Mobile Number';
              }
              if (RegExp(r'^01[3-9]\d{8}$').hasMatch(value!) == false) {
                return 'Enter valid Mobile Number';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(hintText: 'City'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid City';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            maxLines: 3,
            controller: _shippingAddressTEController,
            decoration: const InputDecoration(hintText: 'Shipping Address'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Shipping address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
