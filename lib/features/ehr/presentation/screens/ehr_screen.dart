import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class EHRScreen extends StatefulWidget {
  const EHRScreen({Key? key}) : super(key: key);

  @override
  _EHRScreenState createState() => _EHRScreenState();
}

class _EHRScreenState extends State<EHRScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late final TabController medicalRecordsTabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        setState(() {}); // Force rebuild when tab changes
      });
    medicalRecordsTabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    medicalRecordsTabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left, color: appColors.themeColor, size: 30),
        //   onPressed: () {
        //     Get.offAll(() => MainBottomNavScreen());
        //   },
        // ),
        title: const Text('Electronic Health Records',style: TextStyle(fontSize: 20, color: appColors.themeColor)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Main Tab Bar
            SizedBox(
              height: 50,
              child: RawScrollbar(
                controller: _scrollController,
                thumbColor: appColors.themeColor,
                radius: const Radius.circular(20),
                thickness: 3,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //_buildCustomTab('Summary', 'summary', 0),
                      _buildCustomTab('Prescription (OPD)', 'summary', 0),
                      _buildCustomTab('Health Details', 'health_details', 1),
                      _buildCustomTab('Vitals', 'vitals', 2),
                      _buildCustomTab('Current Medicine', 'current_medicine', 3),
                      _buildCustomTab('Family Disease', 'family_disease', 4),
                      //_buildCustomTab('Medical Records', 'medical_records', 4),

                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildSummaryTab(),
                  _buildHealthDetailsTab(),
                  _buildVitalsTab(),
                  _buildCurrentMedicineTab(),
                  _buildFamilyDiseaseTab(),
                  //_buildMedicalRecordsTab(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTab(String title, String iconName, int index) {
    bool isActive = tabController.index == index;
    return InkWell(
      onTap: () {
        tabController.animateTo(index);
      },
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 0.01),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          height: 50,
          width: _getTabWidth(title),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                child: Image.asset(
                  'assets/images/ehr/$iconName.png',
                  scale: 3.5,
                  color: isActive ? appColors.themeColor : appColors.themeColor, // Keep original color when active
                  fit: BoxFit.contain,
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: _getTabWidth(title) - 44,
                    decoration: BoxDecoration(
                      color: isActive ? appColors.themeColor : Colors.grey[200],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey[600],
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: _CustomTriangleClipper(),
                    child: Container(
                      height: 50,
                      width: 10,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getTabWidth(String title) {
    switch (title) {
      case 'Prescription': return 225.0;
      case 'Health Details': return 175.0;
      case 'Vitals': return 115.0;
      case 'Current Medicine': return 180.0;
      //case 'Medical Records': return 180.0;
      case 'Family Disease': return 175.0;
      default: return 150.0;
    }
  }

  // Widget _buildMedicalRecordsTab() {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 40,
  //         child: TabBar(
  //           controller: medicalRecordsTabController,
  //           isScrollable: true,
  //           labelColor: appColors.themeColor,
  //           unselectedLabelColor: Colors.grey,
  //           tabs: const [
  //             Tab(text: 'Prescription'),
  //             Tab(text: 'Lab Report'),
  //             Tab(text: 'Findings'),
  //             Tab(text: 'Radiology & Imaging'),
  //             Tab(text: 'Surgical History'),
  //             Tab(text: 'Hospitalization History'),
  //             Tab(text: 'Immunization History'),
  //             Tab(text: 'Others'),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: TabBarView(
  //           controller: medicalRecordsTabController,
  //           children: [
  //             _buildPrescriptionSubTab(),
  //             _buildLabReportSubTab(),
  //             _buildFindingsSubTab(),
  //             _buildRadiologySubTab(),
  //             _buildSurgicalHistorySubTab(),
  //             _buildHospitalizationSubTab(),
  //             _buildImmunizationSubTab(),
  //             _buildOthersSubTab(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSummaryTab() {
    return ListView(
      children: [
        _buildSectionTitle('Continue Medicine'),
        _buildMedicineCard('Tab. Paracetamol 500mg', '1-1-1', '7 days'),
        _buildMedicineCard('Cap. Omeprazole 20mg', '1-0-1', '14 days'),
        _buildSectionTitle('Previous Prescription'),
        _buildRecordCard('Prescription #E012203000004', 'Cardiology', '10/10/2023'),
        _buildRecordCard('Prescription #E012203000005', 'General Medicine', '05/10/2023'),
        _buildSectionTitle('Previous Investigation'),
        _buildSimpleRecordCard('Complete Blood Count', '10/10/2023'),
        _buildSimpleRecordCard('Lipid Profile', '05/10/2023'),
      ],
    );
  }

  Widget _buildHealthDetailsTab() {
    return ListView(
      children: [
        _buildSectionTitle('Disease'),
        _buildDetailCard('Diabetes Mellitus Type 2', 'Diagnosed 2020', 'Prescription #E012203000004'),
        _buildSectionTitle('Allergy'),
        _buildDetailCard('Penicillin', 'Severe', 'Medicine Allergy'),
        _buildSectionTitle('Chronic Disease'),
        _buildDetailCard('Hypertension', 'Since 2018', 'Controlled with medication'),
      ],
    );
  }

  Widget _buildVitalsTab() {
    return ListView(
      children: [
        _buildDateRangeFilter(),
        _buildVitalCard('120/80 mmHg', '98.6°F', '72 bpm', '170 cm', '70 kg', '10/10/2023'),
        _buildVitalCard('118/78 mmHg', '98.4°F', '68 bpm', '170 cm', '69 kg', '05/10/2023'),
      ],
    );
  }

  Widget _buildCurrentMedicineTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Medicine',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildMedicineCard('Tab. Metformin 500mg', '1-0-1', '30 days'),
              _buildMedicineCard('Tab. Losartan 50mg', '0-0-1', '30 days'),
              _buildMedicineCard('Cap. Atorvastatin 20mg', '0-0-1', '30 days'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFamilyDiseaseTab() {
    return ListView(
      children: [
        _buildDetailCard('Family History', 'Heart Disease in father', 'Prescription #E012203000004'),
        _buildDetailCard('Drug History', 'Regular NSAID use', 'For chronic back pain'),
        _buildDetailCard('Personal History', 'Smoker - 10 pack years', 'Quit 2020'),
      ],
    );
  }

  // Widget _buildPrescriptionSubTab() {
  //   return ListView(
  //     children: [
  //       _buildRecordCard('Prescription RDHN12203000004', 'Cardiology', '10/10/2023'),
  //       _buildRecordCard('Prescription RDHN12203000004', 'General Medicine', '05/10/2023'),
  //     ],
  //   );
  // }
  //
  // Widget _buildLabReportSubTab() {
  //   return Column(
  //     children: [
  //       _buildFilterSortRow(),
  //       Expanded(
  //         child: ListView(
  //           children: [
  //             _buildRecordCard('CBC', 'Pathology', '10/10/2023'),
  //             _buildRecordCard('Lipid Profile', 'Pathology', '05/10/2023'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildFindingsSubTab() {
  //   return Column(
  //     children: [
  //       _buildFilterSortRow(),
  //       Expanded(
  //         child: ListView(
  //           children: [
  //             _buildFindingsCard('CBC Findings', 'Hemoglobin: 14.2 g/dL', '10/10/2023'),
  //             _buildFindingsCard('Lipid Findings', 'Cholesterol: 180 mg/dL', '05/10/2023'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildRadiologySubTab() {
  //   return Column(
  //     children: [
  //       _buildFilterSortRow(),
  //       Expanded(
  //         child: ListView(
  //           children: [
  //             _buildRecordCard('X-Ray Chest', 'Radiology', '10/10/2023'),
  //             _buildRecordCard('USG Abdomen', 'Radiology', '05/10/2023'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildSurgicalHistorySubTab() {
  //   return ListView(
  //     children: [
  //       _buildSurgicalCard('Appendectomy', '10/10/2020', 'Dr. Smith', 'Normal recovery'),
  //     ],
  //   );
  // }
  //
  // Widget _buildHospitalizationSubTab() {
  //   return ListView(
  //     children: [
  //       _buildHospitalCard('General Ward', '10/10/2020', '12/10/2020', 'Appendicitis'),
  //     ],
  //   );
  // }
  //
  // Widget _buildImmunizationSubTab() {
  //   return ListView(
  //     children: [
  //       _buildImmunizationCard('COVID-19 Vaccine', '10/10/2021', '2nd Dose', 'Pfizer'),
  //     ],
  //   );
  // }
  //
  // Widget _buildOthersSubTab() {
  //   return ListView(
  //     children: [
  //       _buildRecordCard('ECG Report', 'Cardiology', '10/10/2023'),
  //     ],
  //   );
  // }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMedicineCard(String medicine, String dosage, String duration) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(medicine, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.medical_services, size: 16),
                const SizedBox(width: 8),
                Text('Dosage: $dosage'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text('Duration: $duration'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(String title, String department, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(department),
            Text(date),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildSimpleRecordCard(String title, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }

  Widget _buildDetailCard(String title, String detail1, String detail2) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(detail1),
            const SizedBox(height: 4),
            Text(detail2),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'From Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'To Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String bp, String temp, String pulse, String height, String weight, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BP: $bp'),
                    Text('Temp: $temp'),
                    Text('Pulse: $pulse'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Height: $height'),
                    Text('Weight: $weight'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFilterSortRow() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: OutlinedButton.icon(
  //             icon: const Icon(Icons.sort),
  //             label: const Text('Sort By'),
  //             onPressed: () {},
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         Expanded(
  //           child: OutlinedButton.icon(
  //             icon: const Icon(Icons.filter_list),
  //             label: const Text('Filter'),
  //             onPressed: () {},
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildFindingsCard(String title, String findings, String date) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  //           const SizedBox(height: 8),
  //           Text(findings),
  //           const SizedBox(height: 8),
  //           Text(date, style: const TextStyle(color: Colors.grey)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildSurgicalCard(String procedure, String date, String surgeon, String notes) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(procedure, style: const TextStyle(fontWeight: FontWeight.bold)),
  //           const SizedBox(height: 8),
  //           Text('Date: $date'),
  //           Text('Surgeon: $surgeon'),
  //           Text('Notes: $notes'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildHospitalCard(String ward, String admitDate, String dischargeDate, String reason) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Hospitalization', style: const TextStyle(fontWeight: FontWeight.bold)),
  //           const SizedBox(height: 8),
  //           Text('Ward: $ward'),
  //           Text('Admit Date: $admitDate'),
  //           Text('Discharge Date: $dischargeDate'),
  //           Text('Reason: $reason'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildImmunizationCard(String vaccine, String date, String dose, String brand) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(vaccine, style: const TextStyle(fontWeight: FontWeight.bold)),
  //           const SizedBox(height: 8),
  //           Text('Date: $date'),
  //           Text('Dose: $dose'),
  //           Text('Brand: $brand'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class _CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}