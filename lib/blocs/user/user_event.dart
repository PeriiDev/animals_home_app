part of 'user_bloc.dart';

/**
 * El objetivo es crear eventos o metodos que extiendan de UserEvent
 * Al establecerlo de esta forma podemos saber que eventos espera recibir
 */

abstract class UserEvent  {
  const UserEvent();
}

//Este evento será para inicializar mi usuario,
//tengo que enviar el usuario que quiero inicializar
class ActivateUser extends UserEvent {
  final User user;
  const ActivateUser(this.user);
}

class UserSetStateEvent extends UserEvent {
  final User user;
  const UserSetStateEvent({required this.user});
}

class UserBlocEventAutoLogin extends UserEvent {
  /*final User user;
  const UserBlocEventAutoLogin({required this.user});*/
}



//Este evento será para vaciar mi usuario
class DeleteUserEvent extends UserEvent {}