import 'dart:async';
import 'dart:convert';
import 'package:adoptapet_app/models/mini_user.dart';
import 'package:http/http.dart' as http;
import '../adoptapet_package.dart';

class UserServices {
  static Future<String> addAvatar({
    required Map<String, String> body,
    required String filepath,
    required int idUser,
  }) async {
    String addimageUrl = api_url + "/add-avatar-user";

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
    };
    try {

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
    } catch (error) {
      print('Error addAvatar: $error');
    }
    return 'null';
  }

  static Future updateUser({
    required int idUser,
    required String? phone,
    required String? description,
    required DateTime? birthdate,
  }) async {
    final String url = api_url + "/users/$idUser";
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
          },
          body: jsonEncode({
            'phone': phone,
            'description': description,
            'birthdate': (birthdate != null) ? birthdate.toIso8601String() : null,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (error) {
      print('Error updateUser: $error');
    }
    return false;
  }

  static Future getPublicProfile({required int idUser}) async {
    String url = api_url + "/users/$idUser";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });
      print('ESTADO BLOC: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = jsonDecode(response.body);
        return jsonBody;
      }
    } catch (error) {
      print('Error getPublicProfile: $error');
    }
    return null;
  }

  static Future<MiniUser?> getMiniUser({required int idUser}) async {
    String url = api_url + "/mini-user/$idUser";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        return MiniUser.fromMap(jsonBody[0]);
      }
    } catch (error) {
      print('Error getMiniUser: $error');
    }
    return null;
  }
}
