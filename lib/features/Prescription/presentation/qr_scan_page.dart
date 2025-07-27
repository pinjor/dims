import 'dart:io';
import 'dart:math';

import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_logo.dart';
import 'package:ecommerce/features/Prescription/presentation/prescription_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _hasPermission = false;
  bool _isLoading = true;
  bool _showScanner = false;

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
      await Permission.camera.request();
    }
    setState(() {
      _hasPermission = status.isGranted;
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

  void _submitData() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_mobileController.text.isEmpty || _prescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill both mobile number and prescription UID')),
      );
      return;
    }

    // Both fields are filled, proceed with submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data submitted successfully!')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfPath: '',),
      ),
    );


    // Process your data here
    print('Mobile: ${_mobileController.text}');
    print('Prescription UID: ${_prescriptionController.text}');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(),
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
                      SizedBox(height: 60,),
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          AppLogo(),
                        ],
                      ),
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
                              SizedBox(height: 5,),
                              Container(
                                height: 6, // Height of the underline
                                width: 90, // Width of the underline (adjust as needed)
                                color: appColors.themeColor, // Color of the underline
                              ),
                            ],
                          ),
          
                        ],
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: _prescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Prescription UID*',
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
                            return 'Prescription UID is required';
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
                          onPressed: _submitData,
                          child: Text('Submit'),
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