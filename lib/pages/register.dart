import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/services/user_wish_list_services.dart';

import '../blocs/edit_user/edit_user_bloc.dart';
import '../blocs/my_pets/my_pets_bloc.dart';
import '../blocs/user_favourite/user_favourite_bloc.dart';
import '../blocs/user_images/user_images_bloc.dart';
import '../blocs/wish_list/wish_list_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  /*DECLARACIONES DE VARIABLES*/
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmController;

  final GlobalKey<FormState> myFormKey = GlobalKey();

  bool _animalAccount = false;
  bool _hiddenPassword = true;
  bool _hiddenPasswordConfirm = true;

  /*FIN DECLARACIONES*/
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(), //Esconde el teclado
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green,
                    Colors.greenAccent,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: CustomScrollView(
                reverse: false,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: myFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                                  child: const Image(
                                    image: AssetImage('assets/images/icons/dog.png'),
                                    height: 120,
                                    width: 200,
                                  ),
                                ),
                                Text(
                                  'Adopta Pet',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.green[100],
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                                _buildNameInputField(),
                                _buildEmailInputField(),
                                _buildPasswordInputField(),
                                _buildPasswordConfirmInputField(),
                                _animalAccountCheck(),
                              ],
                            ),
                          ),
                          //_buildSocialBtnRow(),
                          //Los siguientes widgets empezaran desde la parte de abajo de la pantalla
                          const SizedBox(height: 40),
                          buildAlreadyHaveAccount(),
                          _registerButton()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //_buildLoginBtn({})
          ],
        ),
      ),
    );
  }

  Widget _buildNameInputField() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 0, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Nombre',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              //contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Introduce tu nombre',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
              ),

              // errorStyle: TextStyle(
              //     color: Colors.red,
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: 'Lato'),
            ),
            validator: ValidatorCustomHelper.validatorNameInput,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInputField() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _emailController,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.sentences,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              //contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Introduce tu e-mail',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
              ),

              // errorStyle: TextStyle(
              //     color: Colors.red,
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: 'Lato'),
            ),
            validator: ValidatorCustomHelper.validatorInputEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInputField() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _hiddenPassword,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              //contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _hiddenPassword = !_hiddenPassword;
                    });
                  },
                  icon: Icon(
                    _hiddenPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
              hintText: 'Introduce tu contraseña',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
              ),
            ),
            validator: validatePasswords,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordConfirmInputField() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 0, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _passwordConfirmController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _hiddenPasswordConfirm,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              //contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _hiddenPasswordConfirm = !_hiddenPasswordConfirm;
                    });
                  },
                  icon: Icon(
                    _hiddenPasswordConfirm ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
              hintText: 'Repite tu contraseña',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
              ),
            ),
            validator: validatePasswords,
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60, top: 20),
      width: double.infinity,
      child: ElevatedButton(
        //elevation: 5.0,
        onPressed: () async {
          //Esconde el teclado
          FocusManager.instance.primaryFocus?.unfocus();
          if (!myFormKey.currentState!.validate()) {
            print('Formulario no valido');
          } else {
            //Vamos a controlar los distintos casos de error
            //1. No coinciden las contraseñas
            _nameController.text = _nameController.text.trim();
            _emailController.text = _emailController.text.trim().toLowerCase();
            _passwordController.text = _passwordController.text.trim();
            _passwordConfirmController.text = _passwordConfirmController.text.trim();

            if (_passwordController.text == _passwordConfirmController.text) {
              //print('Las contraseñas coinciden');
              //Registrar usuario
              final data = await AuthService.signUp(
                email: _emailController.text,
                password: _passwordController.text,
                isAnimalAccount: _animalAccount,
                name: _nameController.text,
                idPushNotification: Preferences.idDevicePushNotificationToken!,
              );
              //print(data);
              if (data['status_code'] == 400) {
                DialogHelper.modalBottom(context, 'Este usuario ya esta registrado', Colors.red.shade300);
              }
              if (data['status_code'] == 500) {
                DialogHelper.modalBottom(context, 'Error con el servidor', Colors.yellow.shade300);
              }

              if (data['status_code'] == 200 || data['status_code'] == 201) {
                DialogHelper.loadingModal(context);
                //await DialogHelper.loadingModalFuture(context: context, milliseconds: 1500);

                final User userBackend = User.fromMap(data["user"]);
                //Le añado el api token al usuario para hacer peticiones
                userBackend.apiToken = data["access_token"];
                //Guardo el token en el telefono para hacer autologin cuando se abra la app
                Preferences.apiTokenBearer = data["access_token"];
                //Añado a mi bloc el usuario que acabo de loguear
                BlocProvider.of<UserBloc>(context, listen: false).add(ActivateUser(userBackend));
                //Lo añado al bloc de editar usuario para editar datos y no modificar el original
                BlocProvider.of<EditUserBloc>(context, listen: false)
                    .add(EditUserEventSetState(newUser: userBackend.copyWith(avatar: 'null')));

                final notification =
                    await UserWishListServices.getNotification(apiToken: userBackend.apiToken!);
                BlocProvider.of<WishListBloc>(context)
                    .add(WishListEventLoadNotification(newWishListForm: notification));

                BlocProvider.of<UserFavouriteBloc>(context).add(UserFavouriteEventLoadData());
                BlocProvider.of<UserImagesBloc>(context).add(UserImagesEventLoadData());
                BlocProvider.of<MyPetsBloc>(context).add(MyPetsEventLoadData());
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
              }
              /*ScaffoldMessenger.of(context).showSnackBar(
                  DialogHelper.modalBottomMessage(
                    'Usuario registrado con exito',
                    Colors.green.shade300,
                  ),
                );*/
            }
          }
          //print(formValues);
          //User? user = await loginUser(formValues);
          //print(user);
          //Asigno el usuario logueado en el controlador
          //mainController.user = user;
          //Cargo la cesta del usuario
          //mainController.bag = await getBagUser(user!.localId, user.idToken);
          //Reenvio a la pagina de home con el usuario en el controlador
          /*Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rotate,
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 600),
                    child: const Home()));*/
          //Navigator.push(context,
          //  PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: const Home()));
          //}
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 24),
          primary: Colors.white,
          minimumSize: const Size.fromHeight(60),
          shape: const StadiumBorder(),
        ),
        child: const Text(
          'Registrarme',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _animalAccountCheck() {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      height: 40.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _animalAccount,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                _animalAccount = value!;
                setState(() {});
                //print(formValues);
              },
            ),
          ),
          const Flexible(
            child: Text(
              'Registrarme como PROTECTORA de animales',
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAlreadyHaveAccount() {
    return GestureDetector(
      onTap: () {
        //Navegacion en modo ios
        /*Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );*/
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Ya tienes una cuenta? ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            'Conectaté',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSocialBtn(Function() onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /*_buildSocialBtn(
            () => print('Login with Facebook'),
            const AssetImage(
              'assets/icon/facebook.jpg',
            ),
          ),*/
          _buildSocialBtn(
            () => print('Login with Google'),
            const AssetImage(
              'assets/images/icons/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  String? validatePasswords(String? value) {
    if (value == null) return null;

    if (value.length < 6) {
      return 'Longitud mínima 6 letras';
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }
}
