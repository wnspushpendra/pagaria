
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webnsoft_solution/main.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProductsPdf{

  static saveAndOpenPdf(File pdfFile, BuildContext context) async {
    // Save the PDF to a permanent location
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/ledger.pdf';
    final savedFile = File(path);
    await savedFile.writeAsBytes(pdfFile.readAsBytesSync());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snackBarButton(context, 'Ledger downloaded', path);
    });

    // Open the saved PDF file
   // OpenFile.open(path);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
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
          buildProductTable(productList, pdfColor, normalFont,boldFont)
        ]));

    final file = await saveDocument(name: 'pagaria_product.pdf', pdf: pdf);
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

  pw.Table buildProductTable(
      List<Product> productList, PdfColor pdfColor, pw.Font font, pw.Font boldFont) {
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
                      font: boldFont, fontWeight: pw.FontWeight.bold, fontSize: 18)),
            ),
            pw.Text('Price',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: boldFont, fontWeight: pw.FontWeight.bold, fontSize: 18)),
            pw.Text('Quantity',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: boldFont, fontWeight: pw.FontWeight.bold, fontSize: 18)),
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
}


/*Future<void> downloadAndOpenPDF(String url,String fileName) async {
  final directory = await getExternalStorageDirectory();
  final taskId = await FlutterDownloader.enqueue(
    url: url,
    savedDir: directory!.path,
    fileName: 'sample.pdf',
    showNotification: true,
    openFileFromNotification: true,
  );

  FlutterDownloader.registerCallback(downloadCallback);
*//*
  FlutterDownloader.registerCallback((id, status, progress) {
    if (status == DownloadTaskStatus.complete.index) {
      openDownloadedFile(directory.path, 'sample.pdf');
    }
  });*//*
}*/

Future<void> openDownloadedFile(String path, String fileName) async {
  final file = File('$path/$fileName');
  if (await file.exists()) {
    final filePath = file.path;
    if (await canLaunch(filePath)) {
      await launch(filePath);
    } else {
      throw 'Could not launch $filePath';
    }
  } else {
    throw 'File does not exist';
  }
}


Future<String> download(Dio dio, String url,String fileName) async {
  var tempDir = await getExternalStorageDirectory();

  try {
    Response response = await dio.get(
      url,
      onReceiveProgress: null,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) { return status! < 500; }
      ),
    );
    var file = File('${tempDir!.path}/myfile.pdf').openSync(mode: FileMode.write);
    file.writeFromSync(response.data);
  //  OpenFile.open('${tempDir.path}/myfile.pdf');
    await file.close();
    return '${tempDir.path}/myfile.pdf';

  } catch (e) {
    print(e);
    return 'failed';
  }
}




