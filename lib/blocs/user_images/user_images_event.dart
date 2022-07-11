part of 'user_images_bloc.dart';

abstract class UserImagesEvent {
  const UserImagesEvent();
}

class UserImagesEventSetStateInitial extends UserImagesEvent {
  UserImagesEventSetStateInitial();
}

class UserImagesEventSetState extends UserImagesEvent {
  final List<UserImage> newUserImageList;
  UserImagesEventSetState({required this.newUserImageList});
}

class UserImagesEventLoadData extends UserImagesEvent {
  UserImagesEventLoadData();
}

class UserImagesEventAddImage extends UserImagesEvent {
  UserImage newUserImage;
  UserImagesEventAddImage({required this.newUserImage});
}
