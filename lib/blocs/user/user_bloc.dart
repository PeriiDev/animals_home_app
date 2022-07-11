import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/user.dart';
import 'package:adoptapet_app/services/auth_services.dart';
import 'package:adoptapet_app/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

//Es la importación para la anotación de @immutable
//Es mas ligero que el de material y se importa aqui pero esta disponible tambien en el resto de partes
import 'package:meta/meta.dart';

/**
 * Podemos hacerlo tambien con widget
 * De esta forma indicamos que este archivo forma parte de estos
 * dos archivos de los que indico que forma parte
 */
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  //Este es el evento al que llamo para realizar cierta accion
  //Este evento será para inicializar mi usuario
  UserBloc() : super(const UserInitialState()) {
    on<ActivateUser>((event, emit) {
      //Si en mi estado no existe un usuario no emito nada
      //if (state.user == null) return;
      print('Nuevo estado del usuario');
      emit(UserSetState(event.user));
      //Si quiero modificar un atributo de un objeto tengo que hacer un copyWith del objeto
      //Para ello programo el metodo copyWith en el modelo de la clase
      //emit(UserSetState(state.user!.copyWith(name: 'Juan')));
    });

    on<UserSetStateEvent>((event, emit) async {
      print('Estado del evento: ${event.user}');
      //TODO LLAMAR A MI SERVICIO PARA GUARDAR EL ESTADO DEL USUARIO NUEVO
      await UserServices.updateUser(
        idUser: event.user.id,
        birthdate: event.user.birthdate,
        description: event.user.description,
        phone: event.user.phone,
      );
      print('Imagen del usuario ${event.user.avatar}');
      //Servicio para guardar la imagen en laravel
      if (event.user.avatar != null || event.user.avatar != '') {
        final String imageName =
            await UserServices.addAvatar(body: {}, filepath: event.user.avatar!, idUser: event.user.id);
        emit(UserSetState(event.user.copyWith(avatar: imageName)));
      } else {
        emit(UserSetState(event.user));
      }
    });

    on<UserBlocEventAutoLogin>((event, emit) async {
      final dataLogin = await AuthService.signIn(Preferences.email, Preferences.password);
      final User userBackend = User.fromMap(dataLogin["user"]);
      userBackend.apiToken = dataLogin["access_token"];
      Preferences.apiTokenBearer = dataLogin["access_token"];
      emit(UserSetStateAutoLogin(newUser: userBackend));
    });

    on<DeleteUserEvent>((event, emit) {
      emit(const UserInitialState());
    });
  }
}
