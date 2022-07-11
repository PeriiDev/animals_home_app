import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc() : super(EditUserSetStateInitial()) {
    
    on<EditUserEventInitial>((event, emit) => emit(EditUserSetStateInitial()));

    on<EditUserEventSetState>((event, emit) {
      print('Copio el estado al hacer login ${event.newUser}');
      emit(EditUserSetState(newUser: event.newUser));
    });
  }
}
