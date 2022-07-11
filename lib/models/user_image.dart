import 'dart:convert';

class UserImage {
  int id;
  int userId;
  String imageGeneral;
  DateTime createdAt;
  DateTime updatedAt;

  UserImage({
    required this.id,
    required this.userId,
    required this.imageGeneral,
    required this.createdAt,
    required this.updatedAt,
  });

  UserImage copyWith({
    int? id,
    int? userId,
    String? imageGeneral,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserImage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageGeneral: imageGeneral ?? this.imageGeneral,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'user_id': userId});
    result.addAll({'image_general': imageGeneral});
    result.addAll({'created_at': createdAt.millisecondsSinceEpoch});
    result.addAll({'updated_at': updatedAt.millisecondsSinceEpoch});

    return result;
  }

  factory UserImage.fromMap(Map<String, dynamic> map) {
    return UserImage(
      id: map['id'],
      userId: map['user_id'],
      imageGeneral: map['image_general'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserImage.fromJson(String source) => UserImage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserImage(id: $id, userId: $userId, imageGeneral: $imageGeneral, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
