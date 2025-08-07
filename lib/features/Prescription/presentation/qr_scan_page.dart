import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/Prescription/presentation/pdf_viewer_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _hasPermission = false;
  bool _isLoading = true;
  bool _showScanner = false;
  bool _isSubmitting = false;

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      setState(() {
        _hasPermission = result.isGranted;
      });
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _mobileController.dispose();
    _prescriptionController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!mounted) return;

      if (scanData.code != null) {
        var data = scanData.code!.split('|');
        if (data.length == 2) {
          setState(() {
            _mobileController.text = data[0];
            _prescriptionController.text = data[1];
            _showScanner = false;
          });

          controller.pauseCamera();
          HapticFeedback.vibrate();
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data scanned successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid QR format. Need both mobile and UID separated by |')),
          );
        }
      }
    });
  }

  Future<Map<String, dynamic>?> _fetchPrescriptionData() async {
    const String apiUrl = 'http://192.168.10.106:9015/api/v1/opd/prescription/findOne-for-mobile-app';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prescriptionNcId': _prescriptionController.text,
          'patientContactNumber': _mobileController.text,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to load prescription data');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching prescription: ${e.toString()}')),
        );
      }
      return null;
    }
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_mobileController.text.isEmpty || _prescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill both mobile number and prescription UID')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final prescriptionData = await _fetchPrescriptionData();

      if (prescriptionData != null && prescriptionData['data'] != null) {
        final data = prescriptionData['data'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerScreen(
              prescriptionNcId: data['prescriptionNcId'] ?? 'N/A',
              departmentName: data['departmentName'] ?? 'N/A',
              doctorName: data['prescribedByName'] ?? 'Unknown Doctor',
              date: data['prescriptionDate'] ?? 'Unknown Date',
              prescriptionId: data['id'] ?? '',
              prescriptionTypeKey: data['prescriptionTypeKey'] ?? '',
              patientName: data['patientName'] ?? 'Unknown Patient',
              appointmentNcId: data['appointmentNcId'] ?? 'N/A',
              appointmentDate: data['appointmentDto']?['appointmentDate'] ?? 'N/A',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No prescription data found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Main Form
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLogo(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prescription',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 6,
                                width: 90,
                                color: appColors.themeColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: _prescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Prescription/Appointment UID*',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.medical_services),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.qr_code),
                            onPressed: () {
                              if (!_hasPermission) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Camera permission required')),
                                );
                                _checkCameraPermission();
                                return;
                              }
                              setState(() {
                                _showScanner = true;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Prescription/Appointment UID is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number*',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile number is required';
                          }
                          if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                            return 'Enter valid 11-digit number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColors.themeColor,
                          ),
                          child: _isSubmitting
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Submit'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('OR', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: appColors.themeColor,
                              ),
                            ),
                          ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text('Login',style: TextStyle(color:appColors.themeColor),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text('Don`t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompleteProfileScreen(),
                                  ),
                                );
                              },
                              child: Text('Create Account'),
                            ),

                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),

              // QR Scanner Overlay
              if (_showScanner) ...[
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    child: Column(
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _showScanner = false;
                              });
                            },
                          ),
                          title: Text('Scan QR Code', style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                              borderColor: Colors.blue,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: min(MediaQuery.of(context).size.width * 0.8, 300),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Text(
                            'Align QR code within frame to scan',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}