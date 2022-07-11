part of 'user_images_bloc.dart';

abstract class UserImagesState {
  List<UserImage> userImageList;
  UserImagesState({required this.userImageList});
}

class UserImagesSetStateInitial extends UserImagesState {
  UserImagesSetStateInitial() : super(userImageList: []);
}

class UserImagesSetState extends UserImagesState {
  List<UserImage> userImageListSet;
  UserImagesSetState({required this.userImageListSet}) : super(userImageList: userImageListSet);
}

class UserImagesSetStateAddImage extends UserImagesState {
  List<UserImage> userImageListSet;
  UserImagesSetStateAddImage({required this.userImageListSet}) : super(userImageList: userImageListSet);
}
