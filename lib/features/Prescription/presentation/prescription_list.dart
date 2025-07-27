import 'package:flutter/material.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildPrescriptionCard(
              doctorName: 'Dr. Ayoub Ali',
              qualifications: 'MBBS, FCPS, MROP',
              rxNumber: '0235148',
              date: '10 July 2025, 06:20 PM',
              branch: 'Dhammondi Branch',
            ),
            const SizedBox(height: 24),
            _buildPrescriptionCard(
              doctorName: 'Dr. Ayoub Ali',
              qualifications: 'MBBS, FCPS, MROP',
              rxNumber: '0235148',
              date: '10 July 2025, 06:20 PM',
              branch: 'Dhammondi Branch',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionCard({
    required String doctorName,
    required String qualifications,
    required String rxNumber,
    required String date,
    required String branch,
  }) {
    return SizedBox(
      width: 350, // Fixed width for precise sizing
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // Left side icon
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.medical_services,
                      size: 28,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              // Prescription content (pushed right to accommodate left icon)
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      qualifications,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Rx ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: rxNumber),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(date),
                    const SizedBox(height: 8),
                    Text(
                      branch,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Right side action buttons
              Positioned(
                right: 8,
                top: 8,
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
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Add Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add_circle_rounded, size: 24),
                        color: Colors.green[800],
                        splashRadius: 20,
                        padding: const EdgeInsets.all(8),
                        onPressed: () {},
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
}