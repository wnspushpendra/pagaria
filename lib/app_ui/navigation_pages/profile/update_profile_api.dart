import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

/// ************** api for edit profile  *************
///
Future<UserResponse> editMarketExecutiveStatus(bool isNewImage,
    String imagePath, Map<String, String> header, body, String roleId) async {
  var endPoints = roleId == '4' ? updateExecutiveProfileApi : updateDistributorProfileApi;

  var request = http.MultipartRequest('POST', Uri.parse(baseUrl + endPoints));
  request.headers.addAll(header);

  if(imagePath.isNotEmpty){
    var image;
    if (isNewImage) {
      /*** if new image selected */
      image = await http.MultipartFile.fromPath('profile_image', imagePath);
    } else {
      /*** if old image passed */
      File file = await downloadImageAndUpload(imagePath);
      image = await http.MultipartFile.fromPath('profile_image', file.path);
    }
    request.files.add(image);
  }

  body.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  /*** send update request  */
  var response = await request.send();
  var responseData = await response.stream.bytesToString();
  UserResponse userData = UserResponse.fromJson(json.decode(responseData));
  return userData;
}
