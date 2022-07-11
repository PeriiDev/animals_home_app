import 'dart:convert';

class MiniUser {
  String name;
  String? avatar;
  String? description;


  MiniUser({
    required this.name,
    this.avatar,
    this.description,
  });

  MiniUser copyWith({
    String? name,
    String? avatar,
    String? description,
  }) {
    return MiniUser(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    if(avatar != null){
      result.addAll({'avatar': avatar});
    }
    if(description != null){
      result.addAll({'description': description});
    }
  
    return result;
  }

  factory MiniUser.fromMap(Map<String, dynamic> map) {
    return MiniUser(
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniUser.fromJson(String source) => MiniUser.fromMap(json.decode(source));
}
