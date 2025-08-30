import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/dims/presentation/medicine_list_details.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MedicineSearchScreen extends StatefulWidget {
  const MedicineSearchScreen({super.key});

  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Medicine> _medicines = [];
  List<Medicine> _filteredMedicines = [];

  // Speech to text
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _speechEnabled = false;

  // Filter options
  String _selectedFilter = 'All';
  String? _selectedCompany;
  String? _selectedPactType;
  String? _searchCriteria; // 'Brand Name' or 'Generic Name'

  // Pact types
  final List<Map<String, dynamic>> _pactTypes = [
    {'name': 'All Types', 'icon': Icons.all_inclusive},
    {'name': 'Tab', 'icon': Icons.tablet},
    {'name': 'Cap', 'icon': Icons.cabin},
    {'name': 'INJ', 'icon': Icons.airline_seat_individual_suite},
    {'name': 'Solution', 'icon': Icons.water_drop},
    {'name': 'Syrup', 'icon': Icons.liquor},
    {'name': 'Cream', 'icon': Icons.create},
    {'name': 'Ointment', 'icon': Icons.healing},
    {'name': 'Powder', 'icon': Icons.grain},
    {'name': 'Suspension', 'icon': Icons.bubble_chart},
    {'name': 'Drops', 'icon': Icons.opacity},
    {'name': 'Inhaler', 'icon': Icons.air},
    {'name': 'Suppository', 'icon': Icons.local_hospital},
  ];

  // Company names
  final List<String> _companies = [
    'All Companies',
    'Pfizer',
    'Novartis',
    'Roche',
    'Merck',
    'GlaxoSmithKline',
    'Sanofi',
    'AstraZeneca',
    'Johnson & Johnson',
    'Natural Health',
  ];

  @override
  void initState() {
    super.initState();
    _initializeMedicines();
    _filteredMedicines = _medicines;

    _speech = stt.SpeechToText();
    _initSpeech();

    _searchController.addListener(() {
      _filterMedicines();
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speech.initialize(
      onStatus: (status) {
        print('Speech status: $status');
        if (status == 'done') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (errorNotification) {
        print('Speech error: $errorNotification');
        setState(() {
          _isListening = false;
        });
      },
    );
    setState(() {});
  }

  void _initializeMedicines() {
    _medicines = [
      Medicine(
        brandName: 'Allegra',
        genericName: 'Fexofenadine',
        dosage: '180mg',
        indication: 'Allergy Relief',
        type: 'Antihistamine',
        company: 'Pfizer',
        pactType: 'Tab',
      ),
      Medicine(
        brandName: 'Valium',
        genericName: 'Diazepam',
        dosage: '5mg',
        indication: 'Anxiety, Muscle Relaxant',
        type: 'Benzodiazepine',
        company: 'Roche',
        pactType: 'Tab',
      ),
      Medicine(
        brandName: 'Zoloft',
        genericName: 'Sertraline',
        dosage: '50mg',
        indication: 'Depression, Panic Disorder',
        type: 'SSRI',
        company: 'Pfizer',
        pactType: 'Cap',
      ),
      Medicine(
        brandName: 'Napa',
        genericName: 'Curcuma longa',
        dosage: '500mg',
        indication: 'Anti-inflammatory',
        type: 'Herbal Supplement',
        company: 'Natural Health',
        pactType: 'Cap',
      ),
      Medicine(
        brandName: 'Lipitor',
        genericName: 'Atorvastatin',
        dosage: '20mg',
        indication: 'Cholesterol',
        type: 'Statin',
        company: 'Pfizer',
        pactType: 'Tab',
      ),
      Medicine(
        brandName: 'Rocephin',
        genericName: 'Ceftriaxone',
        dosage: '1g',
        indication: 'Antibiotic',
        type: 'Cephalosporin',
        company: 'Roche',
        pactType: 'INJ',
      ),
      Medicine(
        brandName: 'Benadryl',
        genericName: 'Diphenhydramine',
        dosage: '25mg/5ml',
        indication: 'Allergy Relief',
        type: 'Antihistamine',
        company: 'Johnson & Johnson',
        pactType: 'Syrup',
      ),
    ];
  }

  void _filterMedicines() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredMedicines = _medicines.where((medicine) {
        final matchesSearch = query.isEmpty ||
            (_selectedFilter == 'All' &&
                (medicine.brandName.toLowerCase().contains(query) ||
                    medicine.genericName.toLowerCase().contains(query) ||
                    medicine.indication.toLowerCase().contains(query) ||
                    medicine.type.toLowerCase().contains(query) ||
                    medicine.company.toLowerCase().contains(query) ||
                    medicine.pactType.toLowerCase().contains(query))) ||
            (_selectedFilter == 'Brand Name' && medicine.brandName.toLowerCase().contains(query)) ||
            (_selectedFilter == 'Generic Name' && medicine.genericName.toLowerCase().contains(query)) ||
            (_selectedFilter == 'Indication' && medicine.indication.toLowerCase().contains(query)) ||
            (_selectedFilter == 'Type' && medicine.type.toLowerCase().contains(query)) ||
            (_selectedFilter == 'Company' && medicine.company.toLowerCase().contains(query)) ||
            (_selectedFilter == 'Pack Type' && medicine.pactType.toLowerCase().contains(query));

        // Company filter
        final matchesCompany = _selectedCompany == null ||
            _selectedCompany == 'All Companies' ||
            medicine.company == _selectedCompany;

        // Pact type filter
        final matchesPactType = _selectedPactType == null ||
            _selectedPactType == 'All Types' ||
            medicine.pactType == _selectedPactType;

        return matchesSearch && matchesCompany && matchesPactType;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCompany = null;
      _selectedPactType = null;
      _searchCriteria = null;
      _selectedFilter = 'All';
      _searchController.clear();
    });
    _filterMedicines();
  }

  void _navigateToMedicineDetails(Medicine medicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineDetailsScreen(medicine: medicine),
      ),
    );
  }

  void _startListening() async {
    if (!_speechEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition is not available')),
      );
      return;
    }

    if (_isListening) {
      setState(() => _isListening = false);
      _speech.stop();
      return;
    }

    setState(() => _isListening = true);
    _speech.listen(
      onResult: (result) {
        setState(() {
          if (result.finalResult) {
            _searchController.text = result.recognizedWords;
            _isListening = false;
          }
        });
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
      partialResults: true,
      localeId: 'en_US',
      onSoundLevelChange: (level) {
        // Optional: You can use this for visual feedback
      },
    );
  }

  String _getHintText() {
    switch (_selectedFilter) {
      case 'Brand Name':
        return 'Search by brand name...';
      case 'Generic Name':
        return 'Search by generic name...';
      case 'Company':
        return 'Search by company...';
      case 'Pack Type':
        return 'Search by pack type...';
      case 'Indication':
        return 'Search by indication...';
      case 'Type':
        return 'Search by medicine type...';
      default:
        return 'Search medicines...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediSearch', style: TextStyle(fontSize: 20)),
        backgroundColor: appColors.themeColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_sharp),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => _buildAllFiltersPanel(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: _getHintText(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.red : Colors.grey),
                  onPressed: _startListening,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),

          // Filter tiles
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterChip('All', Icons.all_inclusive),
                _buildFilterChip('Brand Name', Icons.medication),
                _buildFilterChip('Generic Name', Icons.medical_services),
                _buildFilterChip('Company', Icons.business),
                _buildFilterChip('Pack Type', Icons.local_pharmacy),
                _buildFilterChip('Indication', Icons.health_and_safety),
                _buildFilterChip('Type', Icons.category),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (_isListening)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Listening... Speak now",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: _filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = _filteredMedicines[index];
                return _buildMedicineCard(medicine);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = _selectedFilter == label;

    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        avatar: Icon(icon, size: 16),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
          _filterMedicines();
        },
        selectedColor: appColors.themeColor,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildAllFiltersPanel() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Advanced Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Search criteria radio buttons
            const Text(
              'Search Criteria',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<String>(
                  value: 'Brand Name',
                  groupValue: _searchCriteria,
                  onChanged: (String? value) {
                    setState(() {
                      _searchCriteria = value;
                      _selectedFilter = value!;
                    });
                  },
                  activeColor: appColors.themeColor,
                ),
                const Text('Brand Name'),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'Generic Name',
                  groupValue: _searchCriteria,
                  onChanged: (String? value) {
                    setState(() {
                      _searchCriteria = value;
                      _selectedFilter = value!;
                    });
                  },
                  activeColor: appColors.themeColor,
                ),
                const Text('Generic Name'),
              ],
            ),

            const SizedBox(height: 16),

            // Company filter dropdown
            const Text(
              'Company',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCompany,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: _companies.map((String company) {
                return DropdownMenuItem<String>(
                  value: company,
                  child: Text(company),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCompany = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Pact type filter dropdown
            const Text(
              'Package Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedPactType,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: _pactTypes.map((Map<String, dynamic> pactType) {
                return DropdownMenuItem<String>(
                  value: pactType['name'],
                  child: Row(
                    children: [
                      Icon(pactType['icon'], size: 20),
                      const SizedBox(width: 8),
                      Text(pactType['name']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedPactType = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Filter and Reset buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _filterMedicines();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.themeColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        _resetFilters();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 48),
                      ),
                      child: const Text('Reset All'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(Medicine medicine) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          medicine.brandName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${medicine.genericName} ${medicine.dosage}'),
            const SizedBox(height: 4),
            Text(medicine.indication),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  medicine.type,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    medicine.pactType,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  medicine.company,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _navigateToMedicineDetails(medicine),
      ),
    );
  }
}

class Medicine {
  final String brandName;
  final String genericName;
  final String dosage;
  final String indication;
  final String type;
  final String company;
  final String pactType;

  Medicine({
    required this.brandName,
    required this.genericName,
    required this.dosage,
    required this.indication,
    required this.type,
    required this.company,
    required this.pactType,
  });
}
// class MedicineDetailsScreen extends StatelessWidget {
//   final Medicine medicine;
//
//   const MedicineDetailsScreen({super.key, required this.medicine});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(medicine.brandName),
//         backgroundColor: appColors.themeColor,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               medicine.brandName,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Generic Name: ${medicine.genericName}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Dosage: ${medicine.dosage}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Indication: ${medicine.indication}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Type: ${medicine.type}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Packaging Type: ${medicine.pactType}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Company: ${medicine.company}',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
