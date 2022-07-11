import 'dart:convert';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:http/http.dart' as http;

class NotificationsService {
  static Future sendPushNotifications({
    required String color,
    required String size,
    required String sex,
  }) async {
    String url = api_url + '/push-notifications';

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
        },
        body: jsonEncode(
          {
            'color': color,
            'size': size,
            'sex': sex,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (error) {
      print('Error push notifications $error');
    }
    return false;
  }
}
