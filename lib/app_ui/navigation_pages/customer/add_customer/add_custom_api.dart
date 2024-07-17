

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/AddDistributor.dart';


/// ************** api for adding distributor *************
///
Future<AddDistributorResponse> addDistributorStatus(String imagePath, Map<String, String> header, body,) async {

  var request = http.MultipartRequest('POST', Uri.parse(baseUrl+addDistributorApi));
  request.headers.addAll(header);
  // Add the image file to the request

  if(imagePath.isNotEmpty) {
    var image = await http.MultipartFile.fromPath('profile_image', imagePath);
    request.files.add(image);
  }
  body.forEach((key, value) {
    request.fields[key] = value.toString();
  });
  // Send the request
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  AddDistributorResponse userData = AddDistributorResponse.fromJson(json.decode(responseData));
  return userData;
}

/// ************** api for edit distributor *************
///
Future<AddDistributorResponse> editDistributorStatus(String imagePath, Map<String, String> header, body,) async {

  var request = http.MultipartRequest('POST', Uri.parse(baseUrl+addDistributorApi));
  request.headers.addAll(header);
  // Add the image file to the request
  var image = await http.MultipartFile.fromPath('profile_image', imagePath);
  request.files.add(image);
  body.forEach((key, value) {
    request.fields[key] = value.toString();
  });
  // Send the request
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  AddDistributorResponse userData = AddDistributorResponse.fromJson(json.decode(responseData));
  return userData;
}
