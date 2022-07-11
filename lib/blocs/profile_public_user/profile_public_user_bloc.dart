import 'package:adoptapet_app/models/pet.dart';
import 'package:adoptapet_app/models/user_image.dart';
import 'package:adoptapet_app/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user.dart';

part 'profile_public_user_event.dart';
part 'profile_public_user_state.dart';

class ProfilePublicUserBloc extends Bloc<ProfilePublicUserEvent, ProfilePublicUserState> {
  ProfilePublicUserBloc() : super(ProfilePublicUserSetStateInitial()) {
    on<ProfilePublicUserEventSetState>((event, emit) {
      // TODO: implement event handler
    });

    on<ProfilePublicUserEventLoadData>((event, emit) async {
      //Lanzamos la petición al servidor
      final jsonProfilePrublic = await UserServices.getPublicProfile(idUser: event.idUser);
      
      final User user = User.fromMap(jsonProfilePrublic["user"][0]);
      print('USUARIO :$user');

      final List<dynamic> imgList = jsonProfilePrublic["user_images"];
      final List<UserImage> imagesList = imgList.map((img) => UserImage.fromMap(img)).toList();

      final List<dynamic> petList = jsonProfilePrublic["user_upload"];
      final List<Pet> imagesPets = petList.map((pet) => Pet.fromMap(pet)).toList();

      emit(ProfilePublicUserSetStateLoadData(
          userSet: user, imagesListSet: imagesList, imagesPetsSet: imagesPets));
    });
  }
}
