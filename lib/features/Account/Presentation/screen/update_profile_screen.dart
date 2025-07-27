import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Rahim');
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController(text: '+8801825556666');
  final TextEditingController _emailController = TextEditingController(text: 'abc@gmail.com');

  String? _selectedGender = 'Male';
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _updateDateFields(DateTime(1962, 1, 1));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _getDateFromText(_dobController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _updateDateFields(picked);
    }
  }

  DateTime? _getDateFromText(String text) {
    try {
      final parts = text.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void _updateDateFields(DateTime dob) {
    setState(() {
      _dobController.text = DateFormat('dd/MM/yyyy').format(dob);
      _calculateAge(dob);
    });
  }

  void _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    _ageController.text = age.toString();
  }

  void _calculateDOBFromAge() {
    if (_ageController.text.isNotEmpty) {
      final age = int.tryParse(_ageController.text);
      if (age != null && age > 0) {
        final now = DateTime.now();
        final dob = DateTime(now.year - age, now.month, now.day);
        _updateDateFields(dob);
      }
    }
  }

  void _onDOBChanged(String value) {
    final date = _getDateFromText(value);
    if (date != null) {
      _calculateAge(date);
    }
  }

  bool _isValidBangladeshiPhone(String phone) {
    String digitsOnly = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // International format (+8801XXXXXXXXX)
    if (digitsOnly.startsWith('+880')) {
      return digitsOnly.length == 14 && // +880 1 XXX XXX XXX
          digitsOnly.substring(4, 5) == '1' && // Next digit after 880 should be 1
          ['1', '3', '4', '5', '6', '7', '8', '9'].contains(digitsOnly.substring(4, 5));
    }

    // Local format (01XXXXXXXXX)
    if (digitsOnly.startsWith('01')) {
      return digitsOnly.length == 11 &&
          ['1', '3', '4', '5', '6', '7', '8', '9'].contains(digitsOnly.substring(2, 3));
    }

    return false;
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return true;
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Update Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,

          fontSize: 20,color: appColors.themeColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildFormField('Your Full Name *', _nameController),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: InputBorder.none,
                              hintText: 'DD/MM/YYYY',
                            ),
                            style: const TextStyle(fontSize: 16),
                            onChanged: _onDOBChanged,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today, size: 20),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildFormFieldWithCallback(
                'Age',
                _ageController,
                onChanged: (_) => _calculateDOBFromAge(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      items: _genders.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Number *',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                        hintText: '+8801XXXXXXXXX or 01XXXXXXXXX',
                        prefixIcon: const Icon(Icons.phone, size: 20),
                      ),
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contact number is required';
                        }
                        if (!_isValidBangladeshiPhone(value)) {
                          return 'Enter a valid Bangladeshi number\n'
                              'Format: +8801XXXXXXXXX or 01XXXXXXXXX';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
                        LengthLimitingTextInputFormatter(14),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                        hintText: 'example@domain.com',
                        prefixIcon: const Icon(Icons.email, size: 20),
                      ),
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null && value.isNotEmpty && !_isValidEmail(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Profile updated successfully!'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                      FocusScope.of(context).unfocus();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all required fields correctly'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColors.themeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
            validator: (value) {
              if (label.contains('*') && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFormFieldWithCallback(
      String label,
      TextEditingController controller, {
        required void Function(String) onChanged,
        TextInputType? keyboardType,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
            keyboardType: keyboardType,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}