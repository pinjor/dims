import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_medicine_controller.dart';
import '../../data/models/admin_model.dart';

class MedicineFormScreen extends StatefulWidget {
  final Medicine? medicine;

  const MedicineFormScreen({Key? key, this.medicine}) : super(key: key);

  @override
  State<MedicineFormScreen> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends State<MedicineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final AdminMedicineController _medicineController = Get.find<AdminMedicineController>();

  // Controllers for all form fields
  final _slNumberController = TextEditingController();
  final _manufacturerNameController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _genericNameStrengthController = TextEditingController();
  final _dosageFormController = TextEditingController();
  final _useForController = TextEditingController();
  final _darNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _drugCodeController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _packSizeController = TextEditingController();
  final _specialCategoryController = TextEditingController();
  final _shelfLifeController = TextEditingController();
  final _temperatureConditionController = TextEditingController();
  final _therapeuticClassController = TextEditingController();

  bool get isEditing => widget.medicine != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _populateFields();
    }
  }

  void _populateFields() {
    final medicine = widget.medicine!;
    _slNumberController.text = medicine.slNumber?.toString() ?? '';
    _manufacturerNameController.text = medicine.manufacturerName ?? '';
    _brandNameController.text = medicine.brandName ?? '';
    _genericNameStrengthController.text = medicine.genericNameStrength ?? '';
    _dosageFormController.text = medicine.dosageForm ?? '';
    _useForController.text = medicine.useFor ?? '';
    _darNumberController.text = medicine.darNumber ?? '';
    _categoryController.text = medicine.category ?? '';
    _drugCodeController.text = medicine.drugCode ?? '';
    _countryCodeController.text = medicine.countryCode ?? '';
    _packSizeController.text = medicine.packSize ?? '';
    _specialCategoryController.text = medicine.specialCategory ?? '';
    _shelfLifeController.text = medicine.shelfLife ?? '';
    _temperatureConditionController.text = medicine.temperatureCondition ?? '';
    _therapeuticClassController.text = medicine.therapeuticClass ?? '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Medicine' : 'Add New Medicine'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              _buildTextField(_brandNameController, 'Brand Name *', Icons.medication, isRequired: true),
              _buildTextField(_genericNameStrengthController, 'Generic Name & Strength *', Icons.science, isRequired: true),
              _buildTextField(_manufacturerNameController, 'Manufacturer Name *', Icons.business, isRequired: true),
              _buildTextField(_dosageFormController, 'Dosage Form *', Icons.medication_liquid, isRequired: true),
              _buildTextField(_useForController, 'Use For', Icons.info_outline),

              const SizedBox(height: 24),

              // New Columns Section
              _buildSectionHeader('Additional Information'),
              _buildTextField(_categoryController, 'Category', Icons.category),
              _buildTextField(_drugCodeController, 'Drug Code', Icons.qr_code),
              _buildTextField(_countryCodeController, 'Country Code', Icons.flag),
              _buildTextField(_packSizeController, 'Pack Size', Icons.inventory),
              _buildTextField(_specialCategoryController, 'Special Category', Icons.star),
              _buildTextField(_shelfLifeController, 'Shelf Life', Icons.schedule),
              _buildTextField(_temperatureConditionController, 'Temperature Condition', Icons.thermostat),
              _buildTextField(_therapeuticClassController, 'Therapeutic Class', Icons.medical_services),

              const SizedBox(height: 24),

              // System Information Section
              _buildSectionHeader('System Information'),
              _buildTextField(_slNumberController, 'SL Number', Icons.numbers),
              _buildTextField(_darNumberController, 'DAR Number', Icons.assignment),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                      onPressed: _medicineController.isLoading.value ? null : _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _medicineController.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(isEditing ? 'Update Medicine' : 'Save Medicine'),
                    )),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Error Message
              Obx(() {
                if (_medicineController.errorMessage.value.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _medicineController.errorMessage.value,
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[700],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: isRequired ? (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        } : null,
      ),
    );
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final medicineData = {
        'sl_number': _slNumberController.text.trim().isNotEmpty ? int.tryParse(_slNumberController.text.trim()) : null,
        'manufacturer_name': _manufacturerNameController.text.trim(),
        'brand_name': _brandNameController.text.trim(),
        'generic_name_strength': _genericNameStrengthController.text.trim(),
        'dosage_form': _dosageFormController.text.trim(),
        'use_for': _useForController.text.trim(),
        'dar_number': _darNumberController.text.trim(),
        'category': _categoryController.text.trim(),
        'drug_code': _drugCodeController.text.trim(),
        'country_code': _countryCodeController.text.trim(),
        'pack_size': _packSizeController.text.trim(),
        'special_category': _specialCategoryController.text.trim(),
        'shelf_life': _shelfLifeController.text.trim(),
        'temperature_condition': _temperatureConditionController.text.trim(),
        'therapeutic_class': _therapeuticClassController.text.trim(),
      };

      bool success;
      if (isEditing) {
        success = await _medicineController.updateMedicine(widget.medicine!.id, medicineData);
      } else {
        success = await _medicineController.createMedicine(medicineData);
      }

      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          isEditing ? 'Medicine updated successfully!' : 'Medicine created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
