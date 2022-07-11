part of 'profile_public_user_bloc.dart';

abstract class ProfilePublicUserState {
  User? user;
  List<UserImage> imagesList;
  List<Pet> imagesPets;

  ProfilePublicUserState({required this.user, required this.imagesList, required this.imagesPets});
}

class ProfilePublicUserSetStateInitial extends ProfilePublicUserState {
  ProfilePublicUserSetStateInitial() : super(user: null, imagesList: [], imagesPets: []);
}

class ProfilePublicUserSetState extends ProfilePublicUserState {
  User userSet;
  List<UserImage> imagesListSet;
  List<Pet> imagesPetsSet;
  ProfilePublicUserSetState({required this.userSet, required this.imagesListSet, required this.imagesPetsSet})
      : super(user: userSet, imagesList: imagesListSet, imagesPets: imagesPetsSet);
}

class ProfilePublicUserSetStateLoadData extends ProfilePublicUserState {
  User userSet;
  List<UserImage> imagesListSet;
  List<Pet> imagesPetsSet;
  ProfilePublicUserSetStateLoadData({required this.userSet, required this.imagesListSet, required this.imagesPetsSet})
      : super(user: userSet, imagesList: imagesListSet, imagesPets: imagesPetsSet);
}
