import 'dart:convert';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/form_add_pet.dart';
import 'package:http/http.dart' as http;

import '../models/pet.dart';

enum Aniaml { dog, cat, chicken, dragon }

class PetServices {
  static Future<Map<String, dynamic>> addPet({required FormAddPet newPet}) async {
    const String url = api_url + "/pets";

    try {

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
        },
        body: jsonEncode(newPet.toMap()),
        /* body: jsonEncode({
          "name": newPet.namePet,
          "birthdate": newPet.birthdate,
          "color": newPet.colorPet,
          "weight": newPet.weight,
          "state": newPet.state,
          "sex": newPet.sex,
          "size": newPet.size,
          "description": newPet.description,
          "inoculation": newPet.inoculation,
          "parasites": newPet.parasites,
          "infertile": newPet.infertile,
          "microchip": newPet.microchip,
          "typeAnimal": newPet.typeAnimal,
        }),*/
      );



      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return {
          "status_code": response.statusCode,
          "message": "Pet added successfully",
          "pet": responseData,
        };
      }
      return {
        "status_code": 400,
        "message": "Error adding pet",
      };
    } catch (error) {
      print(error);
    }

    return {
      "status_code": 400,
      "message": "Error adding pet",
    };
  }

  static Future getAvailablePets(int pageNumber) async {
    String url = api_url + "/pets?page=$pageNumber";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        return {
          "status_code": response.statusCode,
          "message": "Pets retrieved successfully",
          "pets": responseData["data"], //Array con objetos de las pets
          "next_page_url": responseData["next_page_url"],
          "prev_page_url": responseData["prev_page_url"],
          "current_page": responseData["current_page"],
          "last_page": responseData["last_page"],
        };
      }
      return {
        "status_code": 400,
        "message": "Error retrieving pets",
      };
    } catch (error) {
      print(error);
    }
  }

  static Future<Pet?> getPet({required int idPet}) async {
    final String url = api_url + "/pets/$idPet";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });


      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> responseData = json.decode(response.body);
        return Pet.fromMap(responseData[0]);
      }
      return null;
    } catch (error) {
      print(error);
    }
  }

  static Future<List<Pet>> getMyPets() async {
    String url = api_url + "/my-pets";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<Pet> result = responseData.map((pet) => Pet.fromMap(pet)).toList();
        return result;
      }
    } catch (error) {
      print(error);
    }
    return [];
  }
}
