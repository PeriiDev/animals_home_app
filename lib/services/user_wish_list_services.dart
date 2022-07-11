import 'dart:convert';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/wish_list_form.dart';
import 'package:http/http.dart' as http;

class UserWishListServices {
  static Future<WishListForm> getNotification({required String apiToken}) async {
    const String url = api_url + '/users-wish-list';

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + apiToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('BODY ${response.body}');
        if (response.body.length > 0) {
          final jsonBody = jsonDecode(response.body);
          final WishListForm wishListForm = WishListForm(
            color: jsonBody["color"],
            sex: jsonBody["sex"],
            size: jsonBody["size"],
            hasNotification: true,
          );
          return wishListForm;
        }
      }
    } catch (error) {
      print('Error en obtener notificacion: $error');
    }
    final noNotification = WishListForm(
      color: '',
      size: 'pequeño',
      sex: 'macho',
      hasNotification: false,
    );
    return noNotification;
  }

  static Future<int> registerNotification({required WishListForm wishList}) async {
    const String url = api_url + '/users-wish-list';

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
        },
        body: jsonEncode(
          {
            'color': wishList.color,
            'size': wishList.size,
            'sex': wishList.sex,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = jsonDecode(response.body);
        return jsonBody["notification"]["id"];
      }
    } catch (error) {
      print(error);
    }
    return -1;
  }

  static Future deleteNotification() async {
    final String url = api_url + '/users-wish-list/${Preferences.idWishList}';

    try {
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
        },
        body: jsonEncode(
          {},
        ),
      );

      print("Delete notification ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }
}
