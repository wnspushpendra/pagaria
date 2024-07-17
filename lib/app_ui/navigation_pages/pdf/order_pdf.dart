import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webnsoft_solution/main.dart';
import 'package:webnsoft_solution/modal/order/order_product.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class OrderPdf {
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

  Future<File> generateProductPdf(
      Order order, List<OrderProduct> productList) async {
    return await generatePdf(
      order,
      productList,
    );
  }

  Future<File> generatePdf(Order order, List<OrderProduct> productList) async {
    final pdf = pw.Document();

    pw.MemoryImage image = await loadImage(logo);
    PdfColor pdfColor = PdfColor.fromInt(Colors.pink.value);
    PdfColor lightBlack = PdfColor.fromInt(Colors.black26.value);
    pw.Font normalFont = await loadFont("assets/font/Roboto-Light.ttf");
    pw.Font boldFont = await loadFont("assets/font/Roboto-Black.ttf");
    pw.Font regularFont = await loadFont("assets/font/Roboto-Regular.ttf");

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              buildHeader(image, pdfColor, boldFont, order),
              customerInformation(image, pdfColor, regularFont,boldFont, order, lightBlack),
              buildProductTable(productList, pdfColor, normalFont, regularFont,
                  boldFont, order, lightBlack),
              bottomData(productList, pdfColor, normalFont, regularFont,
                  boldFont, order, lightBlack)
            ]));

    final file = await saveDocument(name: 'pagaria_product.pdf', pdf: pdf);
    // Open the PDF file after it's generated
    OpenFile.open(file.path);
    return file;
  }

  pw.Widget buildHeader(
          pw.MemoryImage image, PdfColor pdfColor, pw.Font font, Order order) =>
      pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 12),
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Order Number : ${order.id.toString()}',
                    style: pw.TextStyle(
                        font: font,
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: pdfColor)),
                pw.Image(image, width: 100),
              ]));

  pw.Widget customerInformation(pw.MemoryImage image, PdfColor pdfColor,
      pw.Font font, pw.Font boldFont, Order order, PdfColor lightBlack) {
    return pw.Container(
        margin: const pw.EdgeInsets.fromLTRB(0, 10, 0, 20),
        padding: const pw.EdgeInsets.symmetric(vertical: 8),
        decoration: const pw.BoxDecoration(
            border: pw.Border(

              bottom: pw.BorderSide(
                color: PdfColors.black, // Bottom border color
                width: 1, // Bottom border width
              ),
            )),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Name : ${order.bookedUser!.fullName.toString()}',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /* fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                    pw.Text(
                      'Mobile Number : ${order.bookedUser!.contactNo.toString()}',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /* fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                    pw.Text(
                      'Email Address : ${order.bookedUser!.email.toString()}',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /*  fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                    pw.Text(
                      'Address : ${order.bookedUser!.address},${order.bookedUser!.city} ${order.bookedUser!.state} ${order.bookedUser!.zipCode}',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /* fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 4),
              pw.Expanded(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Connect Us',
                      style: pw.TextStyle(
                        font: boldFont,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: pdfColor,
                      ),
                    ),
                    pw.Text(
                      'Mobile Number : 07410-230455,231455',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /* fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                    pw.Text(
                      'Email Address :  info@pagariaglobal.com',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /*  fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                    pw.Text(
                      'Address : 12/233, Ward NO. 12, Jagdevganj Main Road, Alote (M. P.)',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        /* fontWeight: pw.FontWeight.bold,
              color: pdfColor,*/
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }

  pw.Table buildProductTable(
      List<OrderProduct> productList,
      PdfColor pdfColor,
      pw.Font font,
      pw.Font boldFont,
      pw.Font regularFont,
      Order order,
      PdfColor lightBlack) {
    return pw.Table(
      tableWidth: pw.TableWidth.max,
      columnWidths: {
        0: const pw.FlexColumnWidth(5),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(3),
        3: const pw.FlexColumnWidth(3),
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
            pw.Text('Quantity',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: boldFont,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18)),
            pw.Text('Unit Price',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: boldFont,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18)),
            pw.Text('Total',
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
                  child: pw.Text(product.quantity.toString() ?? '',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 18))),
              pw.SizedBox(
                  height: 25,
                  child: pw.Text('${product.amount! / product.quantity!}' ?? '',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 18))),
              pw.SizedBox(
                  height: 25,
                  child: pw.Text(product.amount.toString() ?? '',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 18))),
            ],
          ),
      ],
    );
  }

  bottomData(List<OrderProduct> productList, PdfColor pdfColor, Font normalFont,
      Font regularFont, Font boldFont, Order order, PdfColor lightBlack) {
    return pw.Container(
        width: double.infinity,
        child: pw.Container(
            margin: const pw.EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: const pw.EdgeInsets.symmetric(vertical: 8),
            decoration: const pw.BoxDecoration(
                border: pw.Border(
              top: pw.BorderSide(
                color: PdfColors.black, // Top border color
                width: 1, // Top border width
              ),
              bottom: pw.BorderSide(
                color: PdfColors.black, // Bottom border color
                width: 1, // Bottom border width
              ),
            )),
            child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                      child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Due Amount : ${order.remainingAmount == null ? order.totalAmount.toString() : order.remainingAmount.toString()}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5), // Add spacing between texts
                      pw.Text(
                        'Order Status : ${order.orderStatus.toString()}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                  pw.SizedBox(width: 4),
                  pw.Expanded(
                      child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Subtotal : ${order.totalAmount.toString()}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5), // Add spacing between texts
                      pw.Text(
                        'Total : ${order.totalAmount.toString()}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ))
                ])));
  }
}

/*Future<void> downloadAndOpenPDF(String url, String fileName) async {
  final directory = await getExternalStorageDirectory();
  final taskId = await FlutterDownloader.enqueue(
    url: url,
    savedDir: directory!.path,
    fileName: 'sample.pdf',
    showNotification: true,
    openFileFromNotification: true,
  );

  FlutterDownloader.registerCallback(downloadCallback);
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

Future<String> download(Dio dio, String url, String fileName) async {
  var tempDir = await getExternalStorageDirectory();

  try {
    Response response = await dio.get(
      url,
      onReceiveProgress: null,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    var file =
        File('${tempDir!.path}/myfile.pdf').openSync(mode: FileMode.write);
    file.writeFromSync(response.data);
    //  OpenFile.open('${tempDir.path}/myfile.pdf');
    await file.close();
    return '${tempDir.path}/myfile.pdf';
  } catch (e) {
    print(e);
    return 'failed';
  }
}
