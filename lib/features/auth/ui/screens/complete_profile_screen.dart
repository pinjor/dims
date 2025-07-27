import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';

enum Gender { male, female, other }

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
  final TextEditingController _dateOfBirthTEController = TextEditingController();
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
              SizedBox(height: 15,),
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  AppLogo(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 6, // Height of the underline
                        width: 90, // Width of the underline (adjust as needed)
                        color: appColors.themeColor, // Color of the underline
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 30.0),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpVeificationScreen(),
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



// Add this in your state class
  Gender? _selectedGender;
  DateTime? _selectedDate;

  Widget _buildForm() {
  return Form(
  key: _formKey,
  child: Column(
  children: [
  TextFormField(
  controller: _firstNameTEController,

  decoration:  InputDecoration(hintText: 'Name',
  labelText: 'Name'),
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: (String? value) {
  if (value?.trim().isEmpty ?? true) {
  return 'Enter valid Name';
  }
  return null;
  },
  ),
  const SizedBox(height: 8.0),

    TextFormField(
      controller: _dateOfBirthTEController,
      decoration: InputDecoration(

        hintText: 'Date of Birth',
          labelText: 'Date of Birth',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      readOnly: true, // Prevent manual editing
      onTap: () => _selectDate(context),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please select your date of birth';
        }
        return null;
      },
    ),
  const SizedBox(height: 8.0),
    DropdownButtonFormField<Gender>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        hintText: 'Select Gender',
        border: OutlineInputBorder(),
      ),
      items: Gender.values.map((Gender gender) {
        return DropdownMenuItem<Gender>(
          value: gender,
          child: Text(
            gender.toString().split('.').last.capitalizeFirst!,
          ),
        );
      }).toList(),
      onChanged: (Gender? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
      validator: (Gender? value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    ),
    const SizedBox(height: 8.0),
  TextFormField(
  controller: _mobileTEController,
  decoration: const InputDecoration(hintText: 'Phone Number',
      labelText: 'Phone Number'),
  keyboardType: TextInputType.number,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  maxLength: 11,
  validator: (String? value) {
  if (value?.trim().isEmpty ?? true) {
  return 'Enter your Phone Number';
  }
  if (RegExp(r'^01[3-9]\d{8}$').hasMatch(value!) == false) {
  return 'Enter valid Phone Number';
  }
  return null;
  },
  ),
  const SizedBox(height: 8.0),
  // TextFormField(
  // maxLines: 3,
  // controller: _shippingAddressTEController,
  // decoration: const InputDecoration(hintText: 'Shipping Address'),
  // autovalidateMode: AutovalidateMode.onUserInteraction,
  // validator: (String? value) {
  // if (value?.trim().isEmpty ?? true) {
  // return 'Enter valid Shipping address';
  // }
  // return null;
  // },
  // ),
  ],
  ),
  );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _dateOfBirthTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthTEController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

}
