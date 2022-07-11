part of 'user_favourite_bloc.dart';

abstract class UserFavouriteState {
  List<PetFavourite> favouriteListPet;

  UserFavouriteState({required this.favouriteListPet});
}

class UserFavouriteSetStateInitial extends UserFavouriteState {
  UserFavouriteSetStateInitial() : super(favouriteListPet: []);
}

class UserFavouriteSetState extends UserFavouriteState {
  List<PetFavourite> favouriteListPetSet;
  UserFavouriteSetState({required this.favouriteListPetSet}) : super(favouriteListPet: favouriteListPetSet);
}
