part of 'wish_list_bloc.dart';

abstract class WishListState {
  WishListForm wishListForm;
  WishListState(this.wishListForm);
}

class WishListSetStateInitial extends WishListState {
  WishListSetStateInitial()
      : super(WishListForm(
          color: '',
          size: 'pequeño',
          sex: 'macho',
          hasNotification: false,
        ));
}

class WishListSetState extends WishListState {
  WishListForm newWishListForm;
  WishListSetState({required this.newWishListForm}) : super(newWishListForm);
}
