// ignore_for_file: constant_identifier_names

import 'adoptapet_package.dart';

const String api_url = "https://adoptapet.ovh/public/api";

const String API_STORAGE_PET = "https://adoptapet.ovh/public/pet/";

const String API_STORAGE_BOOK = "https://adoptapet.ovh/public/general/";

const String API_STORAGE_USER = "https://adoptapet.ovh/public/usuarios/";

const String URL_PLACEHOLDER = "https://pacifil.com/public/assets/img/sustainability/placeholder-img-3.jpg";

const Map<String, String>? HEADERS = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

final Map<String, String>? HEADERS_AUTH = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ' + Preferences.apiTokenBearer,
};
