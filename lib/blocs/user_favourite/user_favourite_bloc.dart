import 'package:adoptapet_app/models/pet.dart';
import 'package:adoptapet_app/models/pet_favourite.dart';
import 'package:adoptapet_app/services/user_favourites_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_favourite_event.dart';
part 'user_favourite_state.dart';

class UserFavouriteBloc extends Bloc<UserFavouriteEvent, UserFavouriteState> {
  UserFavouriteBloc() : super(UserFavouriteSetStateInitial()) {
    //First event
    on<UserFavouriteEventLoadData>((event, emit) async {
      final List<PetFavourite> favouriteList = await UserFavouritesServices.getFavouritesUser();
      emit(UserFavouriteSetState(favouriteListPetSet: favouriteList));
    });
    //Lo unico que haremos sera volver a cargar la data cuando añada un nuevo favorito
    on<UserFavouriteEventAddFavourite>((event, emit) async {
      final List<PetFavourite> favouriteList = await UserFavouritesServices.getFavouritesUser();
      emit(UserFavouriteSetState(favouriteListPetSet: favouriteList));
    });

    on<UserFavouriteEventDeleteFavourite>((event, emit) async {
      final List<PetFavourite> favouriteList = await UserFavouritesServices.getFavouritesUser();
      emit(UserFavouriteSetState(favouriteListPetSet: favouriteList));
    });

    on<UserFavouriteEventSetStateInitial>((event, emit) => emit(UserFavouriteSetStateInitial()));
  }
}
