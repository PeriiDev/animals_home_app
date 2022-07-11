import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../adoptapet_package.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormInitialState()) {
    on<AddLoginFormEvent>(_onAddEmailForm);
  }

  void _onAddEmailForm(AddLoginFormEvent event, Emitter<LoginFormState> emit) {
    emit(SetStateForm(
      event.newEmail,
      event.newPassword,
      event.newIsRemember,
      event.newHidePassword,
    ));
  }
}
