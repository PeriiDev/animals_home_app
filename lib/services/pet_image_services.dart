import 'dart:convert';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:http/http.dart' as http;

class PetImageService {
  static Future<String> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = api_url + "/pets-images";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
    };
    final request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response responseOrigin = await http.Response.fromStream(response);
      return jsonDecode(responseOrigin.body)["image"];
    } else {
      return 'null';
    }
  }

}
