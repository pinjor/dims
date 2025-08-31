import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/models/medicine_model.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Medicine Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareMedicine(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            _buildHeaderCard(),
            
            const SizedBox(height: 16),
            
            // Basic Information
            _buildSectionCard(
              title: 'Basic Information',
              icon: Icons.info_outline,
              children: [
                _buildInfoRow('Brand Name', medicine.brandName),
                _buildInfoRow('Generic Name & Strength', medicine.genericNameStrength),
                _buildInfoRow('Manufacturer', medicine.manufacturerName),
                _buildInfoRow('Dosage Form', medicine.dosageForm),
                _buildInfoRow('Use For', medicine.useFor),
                _buildInfoRow('DAR Number', medicine.darNumber, isMonospace: true),
                if (medicine.price != null)
                  _buildInfoRow('Price', '৳${medicine.price!.toStringAsFixed(2)}', isPrice: true),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Medical Information
            if (medicine.indication != null && medicine.indication!.isNotEmpty)
              _buildSectionCard(
                title: 'Medical Information',
                icon: Icons.medical_services,
                children: [
                  _buildInfoRow('Indication', medicine.indication!, isLongText: true),
                ],
              ),
            
            if (medicine.indication != null && medicine.indication!.isNotEmpty)
              const SizedBox(height: 16),
            
            // Dosage Information
            _buildSectionCard(
              title: 'Dosage Information',
              icon: Icons.science,
              children: [
                if (medicine.adultDose != null && medicine.adultDose!.isNotEmpty)
                  _buildInfoRow('Adult Dose', medicine.adultDose!, isLongText: true),
                if (medicine.childDose != null && medicine.childDose!.isNotEmpty)
                  _buildInfoRow('Child Dose', medicine.childDose!, isLongText: true),
                if (medicine.renalDose != null && medicine.renalDose!.isNotEmpty)
                  _buildInfoRow('Renal Dose', medicine.renalDose!, isLongText: true),
                if (medicine.administration != null && medicine.administration!.isNotEmpty)
                  _buildInfoRow('Administration', medicine.administration!, isLongText: true),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Safety Information
            _buildSectionCard(
              title: 'Safety Information',
              icon: Icons.warning_amber,
              children: [
                if (medicine.sideEffects != null && medicine.sideEffects!.isNotEmpty)
                  _buildInfoRow('Side Effects', medicine.sideEffects!, isLongText: true),
                if (medicine.precautionsWarnings != null && medicine.precautionsWarnings!.isNotEmpty)
                  _buildInfoRow('Precautions & Warnings', medicine.precautionsWarnings!, isLongText: true),
                if (medicine.pregnancyLactation != null && medicine.pregnancyLactation!.isNotEmpty)
                  _buildInfoRow('Pregnancy & Lactation', medicine.pregnancyLactation!, isLongText: true),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Technical Information
            _buildSectionCard(
              title: 'Technical Information',
              icon: Icons.biotech,
              children: [
                if (medicine.modeOfAction != null && medicine.modeOfAction!.isNotEmpty)
                  _buildInfoRow('Mode of Action', medicine.modeOfAction!, isLongText: true),
                if (medicine.interaction != null && medicine.interaction!.isNotEmpty)
                  _buildInfoRow('Drug Interactions', medicine.interaction!, isLongText: true),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Timestamps
            _buildSectionCard(
              title: 'Record Information',
              icon: Icons.access_time,
              children: [
                _buildInfoRow('Created', _formatDateTime(medicine.createdAt)),
                _buildInfoRow('Last Updated', _formatDateTime(medicine.updatedAt)),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.brandName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        medicine.genericNameStrength,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                if (medicine.price != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '৳${medicine.price!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildHeaderChip(Icons.business, medicine.manufacturerName),
                const SizedBox(width: 8),
                _buildHeaderChip(Icons.medication, medicine.dosageForm),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[700],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLongText = false, bool isMonospace = false, bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _copyToClipboard(value),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isLongText ? 14 : 15,
                  color: isPrice ? Colors.green[700] : Colors.black87,
                  fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
                  fontFamily: isMonospace ? 'monospace' : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // You can add a snackbar here to show "Copied to clipboard"
  }

  void _shareMedicine(BuildContext context) {
    // Implement sharing functionality
    final shareText = '''
${medicine.brandName}
${medicine.genericNameStrength}
Manufacturer: ${medicine.manufacturerName}
DAR: ${medicine.darNumber}
${medicine.price != null ? 'Price: ৳${medicine.price!.toStringAsFixed(2)}' : ''}
''';
    
    Clipboard.setData(ClipboardData(text: shareText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicine information copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
