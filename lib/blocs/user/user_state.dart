part of 'user_bloc.dart';

/**
 * Creo una clase abstracta para evitar crear instancias de esta clase
 * De esta forma lo que haré sera heredar de ella para obligar a mi nueva clase
 * a tener cierta estructura predeterminada
 */
@immutable
abstract class UserState {
  final User? user;
  final bool existUser;

  const UserState({
    this.user,
    this.existUser = false,
  });
}

class UserInitialState extends UserState {
  const UserInitialState() : super(existUser: false, user: null);
}

class UserSetState extends UserState {
  final User newUser;

  const UserSetState(this.newUser) : super(user: newUser, existUser: true);
}

class UserSetStateAutoLogin extends UserState {
  final User newUser;
  const UserSetStateAutoLogin({required this.newUser}) : super(existUser: true, user: newUser);
}
