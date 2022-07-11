part of 'login_form_bloc.dart';

@immutable
abstract class LoginFormState {
  String email;
  String password;
  bool isRemember;
  bool hidePassword;

  LoginFormState(
      {required this.email,
      required this.password,
      required this.isRemember,
      required this.hidePassword});
}

class LoginFormInitialState extends LoginFormState {
  LoginFormInitialState()
      : super(
          email: "",
          password: "",
          isRemember: false,
          hidePassword: true,
        );
}

class SetStateForm extends LoginFormState {
  final String newEmail;
  final String newPassword;
  final bool newIsRemember;
  final bool newHidePassword;
  SetStateForm(
    this.newEmail,
    this.newPassword,
    this.newIsRemember,
    this.newHidePassword,
  ) : super(
            email: newEmail,
            password: newPassword,
            isRemember: newIsRemember,
            hidePassword: newHidePassword);
}