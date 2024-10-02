import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _printPdf(filePath);
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        onError: (error) {
          print(error.toString());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _printPdf(filePath);
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  void _printPdf(String filePath) async {
    // Load the PDF file as bytes
    final file = File(filePath);
    final pdfBytes = await file.readAsBytes();

    // Print the PDF document
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
