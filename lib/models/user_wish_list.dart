import 'dart:convert';

class UserWishList {
  int id;
  int userId;
  String color;
  String sex;
  String size;
  DateTime createdAt;
  DateTime updatedAt;

  UserWishList({
    required this.id,
    required this.userId,
    required this.color,
    required this.sex,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  UserWishList copyWith({
    int? id,
    int? userId,
    String? color,
    String? sex,
    String? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserWishList(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      color: color ?? this.color,
      sex: sex ?? this.sex,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'color': color});
    result.addAll({'sex': sex});
    result.addAll({'size': size});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});

    return result;
  }

  factory UserWishList.fromMap(Map<String, dynamic> map) {
    return UserWishList(
      id: map['id'],
      userId: map['user_id'],
      color: map['color'],
      sex: map['sex'],
      size: map['size'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserWishList.fromJson(String source) => UserWishList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserWishList(id: $id, userId: $userId, color: $color, sex: $sex, size: $size, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
