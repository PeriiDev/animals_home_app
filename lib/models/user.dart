import 'dart:convert';

class User {
  int id;
  int rolId;
  String name;
  String email;
  String? apiToken;
  DateTime? emailVerifiedAt;
  String? description;
  String? avatar;
  String? phone;
  String? dni;
  DateTime? birthdate;
  DateTime createdAt;
  DateTime updatedAt;
  String? idPushNotificationToken;

  User({
    required this.id,
    required this.rolId,
    required this.name,
    required this.email,
    this.apiToken = '',
    this.emailVerifiedAt,
    this.description,
    this.avatar,
    this.phone,
    this.dni,
    this.birthdate,
    required this.createdAt,
    required this.updatedAt,
    this.idPushNotificationToken,
  });

  User copyWith({
    int? id,
    int? rolId,
    String? name,
    String? email,
    String? apiToken,
    DateTime? emailVerifiedAt,
    String? description,
    String? avatar,
    String? phone,
    String? dni,
    DateTime? birthdate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? idPushNotificationToken,
  }) =>
      User(
        id: id ?? this.id,
        rolId: rolId ?? this.rolId,
        name: name ?? this.name,
        email: email ?? this.email,
        apiToken: apiToken ?? this.apiToken,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        description: description ?? this.description,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        dni: dni ?? this.dni,
        birthdate: birthdate ?? this.birthdate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        idPushNotificationToken:
            idPushNotificationToken ?? this.idPushNotificationToken,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        rolId: json["rol_id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        description: json["description"],
        avatar: json["avatar"],
        phone: json["phone"],
        dni: json["dni"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idPushNotificationToken: json["push_notification_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rol_id": rolId,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "description": description,
        "avatar": avatar,
        "phone": phone,
        "dni": dni,
        "birthdate": birthdate?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "push_notification_id": idPushNotificationToken,
      };

  @override
  String toString() {
    return 'User(id: $id, rolId: $rolId, name: $name, email: $email, apiToken: $apiToken, emailVerifiedAt: $emailVerifiedAt, description: $description, avatar: $avatar, phone: $phone, dni: $dni, birthdate: $birthdate, createdAt: $createdAt, updatedAt: $updatedAt, idPushNotificationToken: $idPushNotificationToken)';
  }
}
