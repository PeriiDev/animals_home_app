part of 'user_favourite_bloc.dart';

abstract class UserFavouriteEvent {
  const UserFavouriteEvent();
}

class UserFavouriteEventSetStateInitial extends UserFavouriteEvent {
  UserFavouriteEventSetStateInitial();
}


class UserFavouriteEventSetState extends UserFavouriteEvent {
  final List<PetFavourite> favouriteListPet;
  UserFavouriteEventSetState({required this.favouriteListPet});
}


class UserFavouriteEventLoadData extends UserFavouriteEvent {
  UserFavouriteEventLoadData();
}

class UserFavouriteEventAddFavourite extends UserFavouriteEvent {
  UserFavouriteEventAddFavourite();
}

class UserFavouriteEventDeleteFavourite extends UserFavouriteEvent {
  UserFavouriteEventDeleteFavourite();
}
