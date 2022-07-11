import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:adoptapet_app/enviroments.dart';

class AuthService {
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required bool isAnimalAccount,
    required String name,
    required String idPushNotification,
  }) async {
    const String url = api_url + "/signup";

    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: HEADERS,
          body: jsonEncode({
            'email': email,
            'password': password,
            'isAnimalAccount': isAnimalAccount,
            'name': name,
            'idPushNotification': idPushNotification,
          }));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return {
          "status_code": response.statusCode,
          "user": responseData['data'],
          "access_token": responseData['access_token'],
        };
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return {
          "status_code": response.statusCode,
          "user": null,
        };
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      print(err);
    }
    return {
      "status_code": 500,
    };
  }

  //LOGIN PRINCIPAL DE LA APP
  static Future<Map<String, dynamic>> signIn(String email, String password) async {
    const String url = api_url + "/signin";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return {
          "status_code": response.statusCode,
          "access_token": responseData['access_token'],
          "message": "Te has conectado con éxito",
          "user": responseData['user'],
        };
      } else if (response.statusCode == 401) {
        //No autorizado, el email o pass no son correctas
        return {
          "status_code": response.statusCode,
          "message": "El email o la contraseña no son correctas",
        };
        //throw Exception('Failed to login');
      }
    } catch (err) {
      print(err);
    }

    return {
      "status_code": 400,
      "message": "No se pudo conectar con el servidor",
    };
  }

  static Future<Map<String, dynamic>> logout(String? bearerToken) async {
    const String url = api_url + "/logout";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearerToken'
      });
      if (response.statusCode == 200) {
        return {
          "status_code": response.statusCode,
          "message": 'Usuario desconectado con éxito',
        };
      } else {
        throw Exception('Failed to logout');
      }
    } catch (err) {
      print(err);
    }
    return {
      "status_code": 400,
      "message": "Hubo un problema al desconectar al usuario",
    };
  }
}
