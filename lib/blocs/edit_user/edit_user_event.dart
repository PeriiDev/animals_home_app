part of 'edit_user_bloc.dart';

abstract class EditUserEvent {
  EditUserEvent();
}

class EditUserEventInitial extends EditUserEvent {
  EditUserEventInitial();
}

class EditUserEventSetState extends EditUserEvent {
  User? newUser;
  EditUserEventSetState({required this.newUser}) : super();
}
