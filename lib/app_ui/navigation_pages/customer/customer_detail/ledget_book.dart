import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';

class LedgetBookScreen extends StatefulWidget {
  const LedgetBookScreen({super.key});

  @override
  State<LedgetBookScreen> createState() => _LedgetBookScreenState();
}

class _LedgetBookScreenState extends State<LedgetBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* SfPdfViewer.network(
        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
        canShowScrollHead: false,
        canShowPaginationDialog: false,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failed event
          print("error :  ${details.error}");
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('Document loaded');
        },
      )*/
    );
  }
}
