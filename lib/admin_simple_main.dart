import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'core/services/medicine_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const SimpleAdminApp());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();
      
      // Simple authentication - you can change these credentials
      if (username == 'admin' && password == 'admin123') {
        Get.offAll(() => const AdminDashboardScreen());
        Get.snackbar(
          'Success',
          'Welcome to DIMS Admin Panel!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Invalid username or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.lightGreen],
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(32),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      size: 80,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'DIMS Admin Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Default Credentials:\nUsername: admin\nPassword: admin123',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class SimpleAdminApp extends StatelessWidget {
  const SimpleAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DIMS Admin Panel',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      getPages: [
        GetPage(name: '/admin/login', page: () => const AdminLoginScreen()),
        GetPage(name: '/admin/dashboard', page: () => const AdminDashboardScreen()),
      ],
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 1));

      // Simple hardcoded credentials for demo
      if (_usernameController.text == 'admin' && _passwordController.text == 'admin123') {
        Get.offAllNamed('/admin/dashboard');
      } else {
        Get.snackbar(
          'Error',
          'Invalid credentials. Use admin/admin123',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      size: 80,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'DIMS Admin Panel',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Sign In',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Demo Credentials: admin / admin123',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIMS Admin Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed('/admin/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to DIMS Admin Panel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                                     _buildDashboardCard(
                     'Medicines',
                     Icons.medication,
                     Colors.green,
                     () {
                       Get.to(() => const MedicineManagementScreen());
                     },
                   ),
                  _buildDashboardCard(
                    'Users',
                    Icons.people,
                    Colors.orange,
                    () {
                      Get.snackbar(
                        'Info',
                        'User management feature coming soon!',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Reports',
                    Icons.analytics,
                    Colors.purple,
                    () {
                      Get.snackbar(
                        'Info',
                        'Reports feature coming soon!',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                    Colors.grey,
                    () {
                      Get.snackbar(
                        'Info',
                        'Settings feature coming soon!',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicineManagementScreen extends StatefulWidget {
  const MedicineManagementScreen({Key? key}) : super(key: key);

  @override
  State<MedicineManagementScreen> createState() => _MedicineManagementScreenState();
}

class _MedicineManagementScreenState extends State<MedicineManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // All form controllers for medicine_product_type table columns
  final _slNumberController = TextEditingController();
  final _manufacturerNameController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _genericNameStrengthController = TextEditingController();
  final _dosageFormController = TextEditingController();
  final _useForController = TextEditingController();
  final _darNumberController = TextEditingController();
  final _indicationController = TextEditingController();
  final _priceController = TextEditingController();
  final _adultDoseController = TextEditingController();
  final _childDoseController = TextEditingController();
  final _renalDoseController = TextEditingController();
  final _administrationController = TextEditingController();
  final _sideEffectsController = TextEditingController();
  final _precautionsWarningsController = TextEditingController();
  final _pregnancyLactationController = TextEditingController();
  final _modeOfActionController = TextEditingController();
  final _interactionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _drugCodeController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _packSizeController = TextEditingController();
  final _specialCategoryController = TextEditingController();
  final _shelfLifeController = TextEditingController();
  final _temperatureConditionController = TextEditingController();
  final _therapeuticClassController = TextEditingController();
  
  List<Map<String, dynamic>> _medicines = [];
  int _editingIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  @override
  void dispose() {
    _slNumberController.dispose();
    _manufacturerNameController.dispose();
    _brandNameController.dispose();
    _genericNameStrengthController.dispose();
    _dosageFormController.dispose();
    _useForController.dispose();
    _darNumberController.dispose();
    _indicationController.dispose();
    _priceController.dispose();
    _adultDoseController.dispose();
    _childDoseController.dispose();
    _renalDoseController.dispose();
    _administrationController.dispose();
    _sideEffectsController.dispose();
    _precautionsWarningsController.dispose();
    _pregnancyLactationController.dispose();
    _modeOfActionController.dispose();
    _interactionController.dispose();
    _categoryController.dispose();
    _drugCodeController.dispose();
    _countryCodeController.dispose();
    _packSizeController.dispose();
    _specialCategoryController.dispose();
    _shelfLifeController.dispose();
    _temperatureConditionController.dispose();
    _therapeuticClassController.dispose();
    super.dispose();
  }

  void _loadMedicines() async {
    try {
      final response = await MedicineApiService.getMedicines(page: 1, size: 100);
      setState(() {
        _medicines.clear();
        _medicines.addAll(List<Map<String, dynamic>>.from(response['items'] ?? []));
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load medicines: $e',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _addMedicine() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final medicineData = {
          'sl_number': int.tryParse(_slNumberController.text) ?? 0,
          'manufacturer_name': _manufacturerNameController.text.trim(),
          'brand_name': _brandNameController.text.trim(),
          'generic_name_strength': _genericNameStrengthController.text.trim(),
          'dosage_form': _dosageFormController.text.trim(),
          'use_for': _useForController.text.trim(),
          'dar_number': _darNumberController.text.trim(),
          'indication': _indicationController.text.trim(),
          'price': double.tryParse(_priceController.text) ?? 0.0,
          'adult_dose': _adultDoseController.text.trim(),
          'child_dose': _childDoseController.text.trim(),
          'renal_dose': _renalDoseController.text.trim(),
          'administration': _administrationController.text.trim(),
          'side_effects': _sideEffectsController.text.trim(),
          'precautions_warnings': _precautionsWarningsController.text.trim(),
          'pregnancy_lactation': _pregnancyLactationController.text.trim(),
          'mode_of_action': _modeOfActionController.text.trim(),
          'interaction': _interactionController.text.trim(),
          'category': _categoryController.text.trim(),
          'drug_code': _drugCodeController.text.trim(),
          'country_code': _countryCodeController.text.trim(),
          'pack_size': _packSizeController.text.trim(),
          'special_category': _specialCategoryController.text.trim(),
          'shelf_life': _shelfLifeController.text.trim(),
          'temperature_condition': _temperatureConditionController.text.trim(),
          'therapeutic_class': _therapeuticClassController.text.trim(),
        };
        
        if (_editingIndex >= 0) {
          // Update existing medicine
          final medicineId = _medicines[_editingIndex]['id'];
          final response = await MedicineApiService.updateMedicine(medicineId, medicineData);
          
          setState(() {
            _medicines[_editingIndex] = response;
            _editingIndex = -1;
          });
        } else {
          // Create new medicine
          final response = await MedicineApiService.createMedicine(medicineData);
          
          setState(() {
            _medicines.add(response);
          });
        }
        
        // Close loading dialog
        Get.back();
        
        _clearAllFields();
        
        Get.snackbar(
          'Success',
          _editingIndex >= 0 ? 'Medicine updated in database successfully!' : 'Medicine saved to database successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } catch (e) {
        // Close loading dialog
        Get.back();
        
        Get.snackbar(
          'Error',
          'Failed to save medicine: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void _clearAllFields() {
    _slNumberController.clear();
    _manufacturerNameController.clear();
    _brandNameController.clear();
    _genericNameStrengthController.clear();
    _dosageFormController.clear();
    _useForController.clear();
    _darNumberController.clear();
    _indicationController.clear();
    _priceController.clear();
    _adultDoseController.clear();
    _childDoseController.clear();
    _renalDoseController.clear();
    _administrationController.clear();
    _sideEffectsController.clear();
    _precautionsWarningsController.clear();
    _pregnancyLactationController.clear();
    _modeOfActionController.clear();
    _interactionController.clear();
    _categoryController.clear();
    _drugCodeController.clear();
    _countryCodeController.clear();
    _packSizeController.clear();
    _specialCategoryController.clear();
    _shelfLifeController.clear();
    _temperatureConditionController.clear();
    _therapeuticClassController.clear();
  }

  void _editMedicine(int index) {
    setState(() {
      _editingIndex = index;
      final medicine = _medicines[index];
      _slNumberController.text = medicine['sl_number'].toString();
      _manufacturerNameController.text = medicine['manufacturer_name'] ?? '';
      _brandNameController.text = medicine['brand_name'] ?? '';
      _genericNameStrengthController.text = medicine['generic_name_strength'] ?? '';
      _dosageFormController.text = medicine['dosage_form'] ?? '';
      _useForController.text = medicine['use_for'] ?? '';
      _darNumberController.text = medicine['dar_number'] ?? '';
      _indicationController.text = medicine['indication'] ?? '';
      _priceController.text = medicine['price'].toString();
      _adultDoseController.text = medicine['adult_dose'] ?? '';
      _childDoseController.text = medicine['child_dose'] ?? '';
      _renalDoseController.text = medicine['renal_dose'] ?? '';
      _administrationController.text = medicine['administration'] ?? '';
      _sideEffectsController.text = medicine['side_effects'] ?? '';
      _precautionsWarningsController.text = medicine['precautions_warnings'] ?? '';
      _pregnancyLactationController.text = medicine['pregnancy_lactation'] ?? '';
      _modeOfActionController.text = medicine['mode_of_action'] ?? '';
      _interactionController.text = medicine['interaction'] ?? '';
      _categoryController.text = medicine['category'] ?? '';
      _drugCodeController.text = medicine['drug_code'] ?? '';
      _countryCodeController.text = medicine['country_code'] ?? '';
      _packSizeController.text = medicine['pack_size'] ?? '';
      _specialCategoryController.text = medicine['special_category'] ?? '';
      _shelfLifeController.text = medicine['shelf_life'] ?? '';
      _temperatureConditionController.text = medicine['temperature_condition'] ?? '';
      _therapeuticClassController.text = medicine['therapeutic_class'] ?? '';
    });
  }

  void _deleteMedicine(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Medicine'),
        content: const Text('Are you sure you want to delete this medicine?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Show loading indicator
                Get.back(); // Close confirmation dialog
                Get.dialog(
                  const Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                final medicineId = _medicines[index]['id'];
                await MedicineApiService.deleteMedicine(medicineId);
                
                setState(() {
                  _medicines.removeAt(index);
                  if (_editingIndex == index) {
                    _editingIndex = -1;
                    _clearAllFields();
                  }
                });
                
                // Close loading dialog
                Get.back();
                
                Get.snackbar(
                  'Success',
                  'Medicine deleted from database successfully!',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              } catch (e) {
                // Close loading dialog
                Get.back();
                
                Get.snackbar(
                  'Error',
                  'Failed to delete medicine: $e',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _cancelEdit() {
    setState(() {
      _editingIndex = -1;
      _clearAllFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Management'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add/Edit Medicine Form
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _editingIndex >= 0 ? 'Edit Medicine' : 'Add New Medicine',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Basic Information Section
                      const Text('Basic Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _slNumberController,
                              decoration: const InputDecoration(
                                labelText: 'SL Number *',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _manufacturerNameController,
                              decoration: const InputDecoration(
                                labelText: 'Manufacturer Name *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _brandNameController,
                              decoration: const InputDecoration(
                                labelText: 'Brand Name *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _genericNameStrengthController,
                              decoration: const InputDecoration(
                                labelText: 'Generic Name & Strength *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dosageFormController,
                              decoration: const InputDecoration(
                                labelText: 'Dosage Form *',
                                hintText: 'e.g., Tablet, Syrup, Injection',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _useForController,
                              decoration: const InputDecoration(
                                labelText: 'Use For *',
                                hintText: 'e.g., Human, Animal',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _darNumberController,
                              decoration: const InputDecoration(
                                labelText: 'DAR Number *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _priceController,
                              decoration: const InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Medical Information Section
                      const Text('Medical Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _indicationController,
                        decoration: const InputDecoration(
                          labelText: 'Indication',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _adultDoseController,
                        decoration: const InputDecoration(
                          labelText: 'Adult Dose',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _childDoseController,
                        decoration: const InputDecoration(
                          labelText: 'Child Dose',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _renalDoseController,
                        decoration: const InputDecoration(
                          labelText: 'Renal Dose',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _administrationController,
                        decoration: const InputDecoration(
                          labelText: 'Administration',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      
                      // Safety Information Section
                      const Text('Safety Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _sideEffectsController,
                        decoration: const InputDecoration(
                          labelText: 'Side Effects',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _precautionsWarningsController,
                        decoration: const InputDecoration(
                          labelText: 'Precautions & Warnings',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _pregnancyLactationController,
                        decoration: const InputDecoration(
                          labelText: 'Pregnancy & Lactation',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _interactionController,
                        decoration: const InputDecoration(
                          labelText: 'Drug Interactions',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      
                      // Additional Information Section
                      const Text('Additional Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _categoryController,
                              decoration: const InputDecoration(
                                labelText: 'Category',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _drugCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Drug Code',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _countryCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Country Code',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _packSizeController,
                              decoration: const InputDecoration(
                                labelText: 'Pack Size',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _specialCategoryController,
                              decoration: const InputDecoration(
                                labelText: 'Special Category',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _shelfLifeController,
                              decoration: const InputDecoration(
                                labelText: 'Shelf Life',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _temperatureConditionController,
                              decoration: const InputDecoration(
                                labelText: 'Temperature Condition',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _therapeuticClassController,
                              decoration: const InputDecoration(
                                labelText: 'Therapeutic Class',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _modeOfActionController,
                        decoration: const InputDecoration(
                          labelText: 'Mode of Action',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _addMedicine,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(_editingIndex >= 0 ? 'Update' : 'Add Medicine'),
                          ),
                          if (_editingIndex >= 0) ...[
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _cancelEdit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Cancel'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16            ),
            
            // Medicine List
            Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Medicine List',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 400, // Fixed height for the list
                        child: _medicines.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.medication_outlined,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No medicines added yet',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'Add your first medicine product type above',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _medicines.length,
                                itemBuilder: (context, index) {
                                  final medicine = _medicines[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.medication,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        medicine['brand_name'] ?? 'Unknown Medicine',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${medicine['generic_name_strength'] ?? ''} - ${medicine['manufacturer_name'] ?? ''}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'Added: ${medicine['created_at']}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            onPressed: () => _editMedicine(index),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () => _deleteMedicine(index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
