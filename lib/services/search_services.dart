import 'dart:convert';

import 'package:adoptapet_app/models/pet.dart';
import 'package:http/http.dart' as http;

import '../adoptapet_package.dart';

class SearchServices {
  static Future<List<Pet>> searchPets(String searchText) async {
    const String baseUrl = "https://adoptapet.ovh/public/api/search/";

    try {
      final http.Response response = await http.get(Uri.parse(baseUrl + searchText), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final List<Pet> dataPetListConvert = [...jsonResponse.map((pet) => Pet.fromMap(pet)).toList()];

        return dataPetListConvert;

      } else {
        throw Exception('Failed to load pets');
      }
    } catch (error) {
      print(error);
    }
    return [];
  }
}
