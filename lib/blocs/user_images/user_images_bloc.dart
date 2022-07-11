import 'package:adoptapet_app/models/user_image.dart';
import 'package:adoptapet_app/services/user_images_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_images_event.dart';
part 'user_images_state.dart';

class UserImagesBloc extends Bloc<UserImagesEvent, UserImagesState> {
  UserImagesBloc() : super(UserImagesSetStateInitial()) {
    on<UserImagesEventSetStateInitial>((event, emit) => {emit(UserImagesSetStateInitial())});

    on<UserImagesEventSetState>((event, emit) async {});

    //Cargamos todas las imagenes del book del usuario al bloc
    on<UserImagesEventLoadData>((event, emit) async {
      final List<UserImage> userImageList = await UserImagesServices.getUserImages();
      emit(UserImagesSetState(userImageListSet: userImageList));
    });

    //Agrego un nuevo objeto que sera la nueva imagen del usuario para su book
    on<UserImagesEventAddImage>((event, emit) async {
      final copy = [...state.userImageList, event.newUserImage];
      emit(UserImagesSetStateAddImage(userImageListSet: copy));
    });
  }
}
