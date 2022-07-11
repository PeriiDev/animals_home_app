part of 'login_form_bloc.dart';

abstract class LoginFormEvent  {
  const LoginFormEvent();
}

class AddLoginFormEvent extends LoginFormEvent {
  final String newEmail;
  final String newPassword;
  final bool newIsRemember;
  final bool newHidePassword;
  AddLoginFormEvent(
    this.newEmail,
    this.newPassword,
    this.newIsRemember,
    this.newHidePassword,
  );
}

