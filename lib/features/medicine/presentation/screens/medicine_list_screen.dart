import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/models/medicine_model.dart';
import '../../../../core/services/medicine_api_service.dart';
import 'medicine_details_screen.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({Key? key}) : super(key: key);

  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  
  List<Medicine> _medicines = [];
  List<String> _dosageForms = ['Tablet', 'Capsule', 'Syrup', 'Injection', 'Cream'];
  String? _selectedDosageForm;
  
  bool _isLoading = false;
  bool _isSearching = false;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 0;
  
  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _manufacturerController.dispose();
    super.dispose();
  }

  Future<void> _loadMedicines({bool isSearch = false}) async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
      if (isSearch) {
        _isSearching = true;
        _currentPage = 1;
      }
    });

    try {
      Map<String, dynamic> response;
      
      if (_isSearching && (_searchController.text.isNotEmpty || 
          _manufacturerController.text.isNotEmpty || 
          _selectedDosageForm != null)) {
        response = await MedicineApiService.searchMedicines(
          query: _searchController.text.isNotEmpty ? _searchController.text : null,
          manufacturer: _manufacturerController.text.isNotEmpty ? _manufacturerController.text : null,
          dosageForm: _selectedDosageForm,
          page: _currentPage,
          size: 10,
        );
      } else {
        response = await MedicineApiService.getMedicines(
          page: _currentPage,
          size: 10,
        );
      }

      final medicineListResponse = MedicineListResponse.fromJson(response);
      
      setState(() {
        if (_currentPage == 1) {
          _medicines = medicineListResponse.items;
        } else {
          _medicines.addAll(medicineListResponse.items);
        }
        _totalPages = medicineListResponse.pages;
        _totalItems = medicineListResponse.total;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error loading medicines: $e');
    }
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _manufacturerController.clear();
      _selectedDosageForm = null;
      _isSearching = false;
      _currentPage = 1;
    });
    _loadMedicines();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Medicine List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by brand name, generic name, or indication...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue[700]!),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onSubmitted: (value) => _performSearch(),
                ),
                
                const SizedBox(height: 12),
                
                // Filter Row
                Row(
                  children: [
                    // Manufacturer Filter
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _manufacturerController,
                        decoration: InputDecoration(
                          hintText: 'Manufacturer',
                          prefixIcon: const Icon(Icons.business, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue[700]!),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        onSubmitted: (value) => _performSearch(),
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    // Dosage Form Filter
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        value: _selectedDosageForm,
                        isExpanded: true,
                        decoration: InputDecoration(
                          hintText: 'Form',
                          prefixIcon: const Icon(Icons.medication, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue[700]!),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        items: _dosageForms.map((form) {
                          return DropdownMenuItem(
                            value: form,
                            child: Text(
                              form,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDosageForm = value;
                          });
                          _performSearch();
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _performSearch,
                        icon: const Icon(Icons.search, color: Colors.white),
                        label: const Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _clearFilters,
                        icon: const Icon(Icons.clear_all, color: Colors.grey),
                        label: const Text(
                          'Clear',
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results Summary
          if (_totalItems > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.blue[50],
              child: Text(
                'Found $_totalItems medicine${_totalItems == 1 ? '' : 's'}',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          
          // Medicine List
          Expanded(
            child: _isLoading && _medicines.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _medicines.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medication_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No medicines found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search criteria',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _loadMedicines(isSearch: _isSearching),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _medicines.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _medicines.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            
                            final medicine = _medicines[index];
                            return _buildMedicineCard(medicine);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(Medicine medicine) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToDetails(medicine),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Medicine Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.medication,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Medicine Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.brandName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          medicine.genericNameStrength,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Price
                  if (medicine.price != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '৳${medicine.price!.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Details Row
              Row(
                children: [
                  Expanded(
                    child: _buildInfoChip(
                      Icons.business,
                      medicine.manufacturerName,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInfoChip(
                      Icons.medication,
                      medicine.dosageForm,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              
              if (medicine.indication != null && medicine.indication!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  medicine.indication!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              const SizedBox(height: 8),
              
              // DAR Number
              Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'DAR: ${medicine.darNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontFamily: 'monospace',
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

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    _loadMedicines(isSearch: true);
  }

  void _navigateToDetails(Medicine medicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineDetailsScreen(medicine: medicine),
      ),
    );
  }
}
