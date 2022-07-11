import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/wish_list_form.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/user_wish_list_services.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListSetStateInitial()) {
    on<WishListEventInitialState>((event, emit) {
      emit(WishListSetStateInitial());
    });

    on<WishListEventSetState>((event, emit) async {
      emit(WishListSetState(newWishListForm: event.newWishListForm));
    });

    on<WishListEventAdd>((event, emit) async {
      //Estoy registrando una nueva alerta en la base de datos
      Preferences.idWishList =
          await UserWishListServices.registerNotification(wishList: event.newWishListForm);
      emit(WishListSetState(newWishListForm: event.newWishListForm));
    });

    on<WishListEventDelete>((event, emit) async {
      //Aqui voy a eliminar la alerta que tengo registrada
      await UserWishListServices.deleteNotification();
      emit(WishListSetStateInitial());
    });

    on<WishListEventLoadNotification>(
        (event, emit) => emit(WishListSetState(newWishListForm: event.newWishListForm)));
  }
}
