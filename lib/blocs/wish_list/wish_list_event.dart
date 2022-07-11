part of 'wish_list_bloc.dart';

abstract class WishListEvent {
  WishListEvent();
}

class WishListEventInitialState extends WishListEvent {
  WishListEventInitialState();
}

class WishListEventSetState extends WishListEvent {
  final WishListForm newWishListForm;
  WishListEventSetState({required this.newWishListForm});
}

class WishListEventAdd extends WishListEvent {
  final WishListForm newWishListForm;
  WishListEventAdd({required this.newWishListForm});
}

class WishListEventDelete extends WishListEvent {
  final WishListForm newWishListForm;
  WishListEventDelete({required this.newWishListForm});
}

class WishListEventLoadNotification extends WishListEvent {
  final WishListForm newWishListForm;
  WishListEventLoadNotification({required this.newWishListForm});
}
