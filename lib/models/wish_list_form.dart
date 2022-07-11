class WishListForm {
  final String color;
  final String size;
  final String sex;
  final bool hasNotification;

  WishListForm({
    required this.color,
    required this.size,
    required this.sex,
    required this.hasNotification,
  });

  WishListForm copyWith({
    String? color,
    String? size,
    String? sex,
    bool? hasNotification,
  }) {
    return WishListForm(
      color: color ?? this.color,
      size: size ?? this.size,
      sex: sex ?? this.sex,
      hasNotification: hasNotification ?? this.hasNotification,
    );
  }
}
