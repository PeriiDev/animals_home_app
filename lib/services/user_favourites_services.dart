import 'dart:convert';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/pet_favourite.dart';
import 'package:http/http.dart' as http;

class UserFavouritesServices {
  static Future<bool> isFavourite(int idPet) async {
    const String url = api_url + "/favourite";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
        },
        body: jsonEncode({
          "idPet": idPet,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.body[0] == '0') ? false : true;
      }
      return false;
    } catch (error) {
      print(error);
    }
    return false;
  }

  static Future addFavouritePet({required int idPet, required ownerPetId}) async {
    String url = api_url + "/add-favourite-pet";

    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
          },
          body: jsonEncode({
            'idPet': idPet,
            'ownerPetId': ownerPetId,
          }));
      print("Añadir favorito ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status_code": response.statusCode,
          "message": 'Mascota agregada a favoritos con éxito',
        };
      }
    } catch (error) {
      print(error);
    }
  }

  static Future deleteFavouritePet({required int idPet}) async {
    String url = api_url + "/delete-favourite-pet";

    try {
      final http.Response response = await http.delete(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
          },
          body: jsonEncode({
            'idPet': idPet,
          }));
      print("Eliminar favorito ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status_code": response.statusCode,
          "message": 'Mascota eliminada de favoritos con éxito',
        };
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<List<PetFavourite>> getFavouritesUser() async {
    String url = api_url + "/favourite-user";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<PetFavourite> result =
            responseData.map((petFavourite) => PetFavourite.fromMap(petFavourite)).toList();
        return result;
      }
    } catch (error) {
      print(error);
    }
    return [];
  }
}
