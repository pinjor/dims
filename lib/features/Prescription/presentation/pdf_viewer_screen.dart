import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/Prescription/data/services/prescription_service.dart';

class PdfViewerScreen extends StatelessWidget {
  final String prescriptionNcId;
  final String departmentName;
  final String doctorName;
  final String date;
  final String prescriptionId;
  final String patientName;
  final String prescriptionTypeKey;

  const PdfViewerScreen({
    super.key,
    required this.prescriptionNcId,
    this.departmentName = 'N/A',
    this.doctorName = 'N/A',
    this.date = 'N/A',
    required this.prescriptionId,
    required this.prescriptionTypeKey,
    this.patientName = 'N/A',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Details',
            style: TextStyle(fontSize: 20, color: appColors.themeColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildPrescriptionCard(context),
            SizedBox(height: 20),
           // _buildPrescriptionDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // Left side icon
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medical_services,
                      size: 32,
                      color: appColors.themeColor,
                    ),
                  ),
                ),
              ),

              // Prescription content
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'DR. ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: doctorName),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      departmentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   'Prescription ID: $prescriptionNcId',
                    //   style: TextStyle(color: Colors.grey[600]),
                    // ),
                  ],
                ),
              ),

              // Right side action buttons
              Positioned(
                right: 0,
                top: 30,
                child: Column(
                  children: [
                    // Download Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.download_rounded, size: 24),
                        color: Colors.blue[800],
                        splashRadius: 20,
                        padding: const EdgeInsets.all(8),
                        onPressed: () => PrescriptionService.downloadPrescription(
                          prescriptionId: prescriptionId,
                          prescriptionTypeKey: prescriptionTypeKey,
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildPrescriptionDetails() {
  //   return Card(
  //     elevation: 2,
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Prescription Details',
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: appColors.themeColor,
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           // Add your prescription details widgets here
  //           // Example:
  //           // _buildDetailRow('Patient ID', patientRegId),
  //           // _buildDetailRow('Gender', genderName),
  //           // _buildDetailRow('Age', calculateAge(dob)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}