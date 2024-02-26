
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

Future<void> downloadAndOpenFile(String fileName,String url) async {
  try {
    String directoryName = 'pagaria_files';
    // Create directory and save network file
    String savePath = await _getSavePath(directoryName, fileName);
    await _saveNetworkFile(url, savePath);
    print('File saved at: $savePath');
    // Open the saved file
    _openFile(savePath);

  } catch (e) {
    print('Error during download: $e');
  }
}

// Function to get the path for the directory and file
Future<String> _getSavePath(String directoryName, String fileName) async {
  Directory? appExternalDirectory = await getExternalStorageDirectory();
  String directoryPath = '${appExternalDirectory!.path}/$directoryName';
  Directory directory = Directory(directoryPath);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  return '$directoryPath/$fileName';
}

// Function to save network file to local storage
Future<void> _saveNetworkFile(String url, String filePath) async {
  http.Response response = await http.get(Uri.parse(url));
  File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
}

// Function to open a file
void _openFile(String filePath) {
  OpenFile.open(filePath);
}