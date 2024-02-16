import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/product_list_pdf.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class PdfGenerator {
  static Future<void> generateAndOpenPdf(List<Product> productList) async {
    final pdf = pw.Document();
    final image = await loadImage(logo);
    final pdfColor = PdfColor.fromInt(Colors.redAccent.value);

    pdf.addPage(pw.MultiPage(
      build: (context) => [
        buildHeader(image, pdfColor),
        buildProductTable(productList),
      ],
    ));

    final file =
    await PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
    // Open the saved PDF file
    OpenFile.open(file.path);
  }

  // Function to load image data
  static Future<pw.MemoryImage> loadImage(String logo) async {
    final ByteData data = await rootBundle.load(logo);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }

  static pw.Widget buildHeader(pw.MemoryImage image, PdfColor pdfColor) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 12),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Pagaria Product',
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: pdfColor)),
            pw.Image(image, width: 100),
          ],
        ),
      );

  static pw.Table buildProductTable(List<Product> productList) => pw.Table(
    columnWidths: {
      0: const pw.FlexColumnWidth(3),
      1: const pw.FlexColumnWidth(2),
      2: const pw.FlexColumnWidth(1),
    },
    children: [
      pw.TableRow(
        children: [
          pw.SizedBox(
            height: 30,
            child: pw.Text('Product Name',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 18)),
          ),
          pw.Text('Price',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.Text('Quantity',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 18)),
        ],
      ),
      for (var product in productList)
        pw.TableRow(
          children: [
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodName ?? '',
                    style: const pw.TextStyle(fontSize: 18))),
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodDistributorPrice ?? '',
                    style: const pw.TextStyle(fontSize: 18))),
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodMinDistrubutorQty ?? '',
                    style: const pw.TextStyle(fontSize: 18))),
          ],
        ),
    ],
  );
}
