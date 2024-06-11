import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/pdf/pdf_products.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:intl/intl.dart';



// back user home screen
Future<void> backUserHome(BuildContext context) async{
  User user =  await getUser();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Navigator.pushReplacementNamed(context, user.roleId == '4' ? homeRoute :homeDistributorRoute, arguments: user);
  });
}

// back user home screen
Future<void> backToLogin(BuildContext context) async{
  clearPref();
  Navigator.pushReplacementNamed(context,  homeRoute);
}


/// * check internet connection
Future<bool> checkConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  bool connection = connectivityResult != ConnectivityResult.none;
  return connectivityResult != ConnectivityResult.none;
}

 downLoadInvoice(BuildContext context,String pdfUrl,String pdfName) async{
  snackBar(context, 'file download started');
  String response = await download(Dio(),pdfUrl,pdfName);
  if(response == 'failed'){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snackBar(context, 'File download failed');
    });
  }else{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snackBarButton(context, 'Invoice Download', response);
    });
  }
}



Future<Placemark?> getAddressFromLatLng(LocationData locationData) async{
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    if (placemarks.isNotEmpty) {
      return placemarks[0];
      //var _address = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country},, ${placemark.postalCode}';
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}

/// * get user data shared preference
Future<User> getUser() async{
  return await getUserPref(userProfileDataPrefecences);
}

/// ********************* check internet connection
Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    return true; // Internet connection is available
  }
}



/// * get string date to date in  yyyy-MM-dd format
String getStringDateDDMMYYYY(String oldDate) {
  DateTime date = DateFormat('dd/MM/yyyy').parse(oldDate);
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}
/// * get date to string in  yyyy-MM-dd format
String getDDMMYYYYDateString(DateTime dateFormat) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(dateFormat);
  return formattedDate;
}
/// * get formated date to string server date
String getDDMMYYYYDateStringDate(String date ) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);
  return formattedDate;
}
/// * get formated date to string server date
String getDDMMYYYYHHMMDateStringDate(String date ) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat('dd-MM-yyyy HH : mm').format(originalDate);
  return formattedDate;
}

String getHHMMFromHHMMSS(String timeString) {
  DateTime dateTime = DateFormat("HH:mm:ss").parse(timeString);
  String formattedTime = DateFormat("HH:mm").format(dateTime);
  return formattedTime;
}

/// * get day from date
String getDayName(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String dayName = DateFormat('EEEE').format(date);
  return dayName;
}



/// * showing a snackBar
snackBar(BuildContext context, String message) {
  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8))),
    margin: const EdgeInsets.all(4),
    duration: const Duration(seconds: 1),
    backgroundColor: primaryColor,
    content: BodyText(text: message,color: Colors.white,),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


/// * showing a snackBar with button
snackBarButton(BuildContext context, String message,String path) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: const EdgeInsets.all(4),
    duration: const Duration(seconds: 10),
    backgroundColor: primaryColor,
    content: BodyText(
      text: message,
      color: Colors.white,
      align: TextAlign.start,
    ),
    action: SnackBarAction(
      backgroundColor: bodyLightBlack,
      label: 'Open',
      onPressed: () => OpenFile.open(path),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


/// * get server image and convert it simple file format
Future<File> downloadImageAndUpload(String imagePath) async {
  // Download the image from the first server
  http.Response response = await http.get(Uri.parse(imagePath));
  // Create a file from the downloaded image data
  final Directory tempDir = Directory.systemTemp;
  File imageFile = File('${tempDir.path}/downloaded_image.jpg');
  await imageFile.writeAsBytes(response.bodyBytes);
  return imageFile;
}

/// * select date date picker
Future<String> selectDate(BuildContext context) async {
  String selectedCalendarDate = '';
  var todayDate =  DateTime.now();

  final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime(todayDate.year-10, todayDate.month, todayDate.day),
      firstDate: DateTime(todayDate.year-100,todayDate.month, todayDate.day),
      lastDate: DateTime(todayDate.year-10, todayDate.month, todayDate.day)
  );

  if (picked != null ) {
     selectedCalendarDate = getDDMMYYYYDateString(picked);
  }
  return selectedCalendarDate;
}

/// * select time time picker
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

/// * pick image file from gallery
Future<XFile?> pickSingleFile() async {
   final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image;
}
/// * capture image file from camera
Future<XFile?> picCameraImage() async{
  final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
  return image;
}

/// * select multiple images from gallery
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

/// * select multiple file from file
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
