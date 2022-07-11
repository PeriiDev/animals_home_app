import 'dart:convert';

class FormAddPet {
  final String namePet;
  final String colorPet;
  final String typeAnimal;
  final String imagePet;
  final String state;
  final String sex;
  final String size;
  final double weight;
  final String description;
  final bool inoculation;
  final bool parasites;
  final bool infertile;
  final bool microchip;
  final DateTime? birthdate;

  FormAddPet({
    required this.namePet,
    required this.colorPet,
    required this.typeAnimal,
    required this.imagePet,
    required this.state,
    required this.sex,
    required this.size,
    required this.weight,
    required this.description,
    required this.parasites,
    required this.inoculation,
    required this.infertile,
    required this.microchip,
    required this.birthdate,
  });

  FormAddPet copyWith({
    String? namePet,
    String? colorPet,
    String? typeAnimal,
    String? imagePet,
    String? state,
    String? sex,
    String? size,
    double? weight,
    String? description,
    bool? inoculation,
    bool? parasites,
    bool? infertile,
    bool? microchip,
    DateTime? birthdate,
  }) {
    return FormAddPet(
      namePet: namePet ?? this.namePet,
      colorPet: colorPet ?? this.colorPet,
      typeAnimal: typeAnimal ?? this.typeAnimal,
      imagePet: imagePet ?? this.imagePet,
      state: state ?? this.state,
      sex: sex ?? this.sex,
      size: size ?? this.size,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      inoculation: inoculation ?? this.inoculation,
      parasites: parasites ?? this.parasites,
      infertile: infertile ?? this.infertile,
      microchip: microchip ?? this.microchip,
      birthdate: birthdate ?? this.birthdate,
    );
  }

  @override
  String toString() {
    return 'FormAddPet(namePet: $namePet, colorPet: $colorPet, typeAnimal: $typeAnimal, imagePet: $imagePet, state: $state, sex: $sex, size: $size, weight: $weight, description: $description, inoculation: $inoculation, parasites: $parasites, infertile: $infertile, microchip: $microchip, birthdate: $birthdate)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': namePet});
    result.addAll({'color': colorPet});
    result.addAll({'typeAnimal': typeAnimal});
    //result.addAll({'imagePet': imagePet});
    result.addAll({'state': state});
    result.addAll({'sex': sex});
    result.addAll({'size': size});
    result.addAll({'weight': weight});
    result.addAll({'description': description});
    result.addAll({'inoculation': inoculation});
    result.addAll({'parasites': parasites});
    result.addAll({'infertile': infertile});
    result.addAll({'microchip': microchip});
    if (birthdate != null) {
      result.addAll({'birthdate': birthdate!.toIso8601String()});
    }

    return result;
  }

  factory FormAddPet.fromMap(Map<String, dynamic> map) {
    return FormAddPet(
      namePet: map['namePet'] ?? '',
      colorPet: map['colorPet'] ?? '',
      typeAnimal: map['typeAnimal'] ?? '',
      imagePet: map['imagePet'] ?? '',
      state: map['state'] ?? '',
      sex: map['sex'] ?? '',
      size: map['size'] ?? '',
      weight: map['weight']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      inoculation: map['inoculation'] ?? false,
      parasites: map['parasites'] ?? false,
      infertile: map['infertile'] ?? false,
      microchip: map['microchip'] ?? false,
      birthdate: map['birthdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthdate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormAddPet.fromJson(String source) =>
      FormAddPet.fromMap(json.decode(source));
}
