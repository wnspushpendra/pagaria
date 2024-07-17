import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';

class PdfApi {
  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
}

saveAndOpenPdf(File pdfFile) async {
  // Save the PDF to a permanent location
  final directory = await getExternalStorageDirectory();
  final path = '${directory!.path}/my_invoice.pdf';
  final savedFile = File(path);
  await savedFile.writeAsBytes(pdfFile.readAsBytesSync());
  // Open the saved PDF file
  OpenFile.open(path);
}

// Function to load image data
Future<pw.MemoryImage> loadImage(String logo) async {
  final ByteData data = await rootBundle.load(logo);
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.MemoryImage(bytes);
}

Future<pw.Font> loadFont(String fontPath) async {
  final ByteData fontData = await rootBundle.load(fontPath);
  final Uint8List fontBytes = fontData.buffer.asUint8List();
  final ByteData fontByteData = ByteData.view(fontBytes.buffer);
  return pw.Font.ttf(fontByteData);
}

 Future<File> generateProductPdf(List<Product> productList) async {
  return await generatePdf(productList);
}

 Future<File> generatePdf(List<Product> productList) async {
  final pdf = pw.Document();
  pw.MemoryImage image = await loadImage(logo);
  PdfColor pdfColor = PdfColor.fromInt(Colors.pink.value);
  pw.Font normalFont = await loadFont("assets/font/Roboto-Light.ttf");
  pw.Font boldFont = await loadFont("assets/font/Roboto-Black.ttf");

  pdf.addPage(pw.MultiPage(
      build: (context) => [
            buildHeader(image, pdfColor, boldFont),
            buildProductTable(productList, pdfColor, normalFont, boldFont)
          ]));

  final file = await PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  // Open the PDF file after it's generated
  OpenFile.open(file.path);
  return file;
}

pw.Widget buildHeader(pw.MemoryImage image, PdfColor pdfColor, pw.Font font) =>
    pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 12),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Pagaria Product',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: pdfColor)),
              pw.Image(image, width: 100),
            ]));

pw.Table buildProductTable(List<Product> productList, PdfColor pdfColor,
    pw.Font font, pw.Font boldFont) {
  return pw.Table(
    //  border: pw.TableBorder.all(),
    columnWidths: {
      0: const pw.FlexColumnWidth(3),
      1: const pw.FlexColumnWidth(2),
      2: const pw.FlexColumnWidth(1),
    },
    children: [
      // Table header
      pw.TableRow(
        children: [
          pw.SizedBox(
            height: 30,
            child: pw.Text('Product Name',
                style: pw.TextStyle(
                    font: boldFont,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18)),
          ),
          pw.Text('Price',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  font: boldFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18)),
          pw.Text('Quantity',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  font: boldFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
      // Table body
      for (var product in productList)
        pw.TableRow(
          children: [
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodName ?? '',
                    style: pw.TextStyle(font: font, fontSize: 18))),
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodDistributorPrice ?? '',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(font: font, fontSize: 18))),
            pw.SizedBox(
                height: 25,
                child: pw.Text(product.prodMinDistrubutorQty ?? '',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(font: font, fontSize: 18))),
          ],
        ),
      /* // Table footer
        pw.TableRow(
          children: [
            pw.Text(''), // Add your footer content here
            pw.Text('Footer Column 2'),
            pw.Text('Footer Column 3'),
          ],
        ),*/
    ],
  );
}



