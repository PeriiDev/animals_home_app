part of 'profile_public_user_bloc.dart';

abstract class ProfilePublicUserEvent {
  const ProfilePublicUserEvent();
}

class ProfilePublicUserEventSetStateInitial extends ProfilePublicUserEvent {
  ProfilePublicUserEventSetStateInitial();
}

class ProfilePublicUserEventSetState extends ProfilePublicUserEvent {
  final User userSet;
  final List<UserImage> imagesListSet;
  final List<Pet> imagesPetsSet;
  ProfilePublicUserEventSetState(
      {required this.userSet, required this.imagesListSet, required this.imagesPetsSet});
}

class ProfilePublicUserEventLoadData extends ProfilePublicUserEvent {
  int idUser;
  ProfilePublicUserEventLoadData({required this.idUser});
}
