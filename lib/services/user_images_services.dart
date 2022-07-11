import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/user_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserImagesServices {
  static Future uploadUserImageGeneral({
    required String filepath,
  }) async {
    String addimageUrl = api_url + "/user-images";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
    };
    try {
      final request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
        ..fields.addAll({})
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath));

      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        http.Response responseOrigin = await http.Response.fromStream(response);
        return jsonDecode(responseOrigin.body)["image_general"];
      } else {
        return 'null';
      }
    } catch (error) {
      print('Error addAvatar: $error');
    }
    return 'null';
  }

  //Trae una lista de todas las imagenes del usuario logueado pertenecientes
  //al book del usuario.
  static Future<List<UserImage>> getUserImages() async {
    String url = api_url + "/user-images";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<UserImage> result = responseData.map((userImage) => UserImage.fromMap(userImage)).toList();
        return result;
      }
    } catch (error) {
      print(error);
    }
    return [];
  }
}
