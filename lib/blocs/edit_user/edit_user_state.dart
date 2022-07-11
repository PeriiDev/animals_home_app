part of 'edit_user_bloc.dart';

abstract class EditUserState {
  User? user;
  EditUserState({this.user});
}

class EditUserSetStateInitial extends EditUserState {
  EditUserSetStateInitial() : super(user: null);
}

class EditUserSetState extends EditUserState {
  User? newUser;
  EditUserSetState({required this.newUser}) : super(user: newUser);
}
