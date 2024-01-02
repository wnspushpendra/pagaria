import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';


/*
String getStringDateDDMMYYYY(String oldDate) {
  DateTime date = DateFormat('dd/MM/yyyy').parse(oldDate);
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}
String getDDMMYYYYDateString(DateTime dateFormat) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(dateFormat);
  return formattedDate;
}*/

snackBar(BuildContext context, String message) {
  var snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: primaryColor,
    content: BodyText(text: message,color: Colors.white,),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

onPopReplace(BuildContext context, String route){
  Navigator.pushReplacementNamed(context, route);
}

void shareOnWhatsApp() async {
const String recipientNumber = '8827176446'; // Replace with the recipient's number
  const url = 'https://wa.me/$recipientNumber?text=Check%20out%20this%20PDF:%20$pdfUrls';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

/*Future<String> selectDate(BuildContext context,DateTime selectedDate) async {
  String selectedCalendarDate = '';
  var todayDate =  DateTime.now();

  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(todayDate.year-10, todayDate.month, todayDate.day),
      firstDate: DateTime(todayDate.year-100,todayDate.month, todayDate.day),
      lastDate: DateTime(todayDate.year-10, todayDate.month, todayDate.day));
  if (picked != null && picked != selectedDate) {
      selectedDate = picked;
     selectedCalendarDate =  getDDMMYYYYDateString(selectedDate);
  }
  return selectedCalendarDate;
}*/

Future<String> selectTime(BuildContext context,TimeOfDay selectedTime) async {
  String time = '';
  final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      });
  if (pickedS != null && pickedS != selectedTime) {
      selectedTime = pickedS ;
      time =  "${selectedTime.hour} : ${selectedTime.minute}";
  }
  return time;
}

Future<File> pickSingleFile() async {
   final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(image!.path);
}

Future<File> picCameraImage() async{
  final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
  return File(image!.path);
}

Future<List<File>> pickMultipleImage() async {
  List<File> fileList = [];
  List<XFile>? imageFileList = [];
  var imagePicker = ImagePicker();
  final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    imageFileList.addAll(selectedImages);
    for (var element in imageFileList) {
      fileList.add(File(element.path));
  }
  return fileList;
}

Future<List<File>> pickMultipleFiles() async {
  List<File> files = [];
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
  );
  if (result != null) {
    files = result.paths.map((path) => File(path!)).toList();
  }
  return files;
}
