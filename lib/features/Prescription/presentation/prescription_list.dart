import 'package:ecommerce/features/Prescription/presentation/PdfDownloader.dart';
import 'package:flutter/material.dart';


class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF '),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => PdfDownloader.downloadPdf(
              context: context,
              sourcePath: pdfPath,
              fileName: 'pres.pdf',
            ),
          ),
        ],
      ),
      body: const Center(child: Text('PDF Content Here')),
    );
  }
}