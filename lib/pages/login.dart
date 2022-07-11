import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/blocs/edit_user/edit_user_bloc.dart';
import 'package:adoptapet_app/blocs/my_pets/my_pets_bloc.dart';
import 'package:adoptapet_app/blocs/user_favourite/user_favourite_bloc.dart';
import 'package:adoptapet_app/blocs/user_images/user_images_bloc.dart';
import 'package:adoptapet_app/blocs/wish_list/wish_list_bloc.dart';
import 'package:adoptapet_app/services/google_signin_services.dart';
import 'package:adoptapet_app/services/user_wish_list_services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  /*DECLARACIONES DE VARIABLES*/
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> myFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final loginFormBloc = BlocProvider.of<LoginFormBloc>(context, listen: false);
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Scaffold(
          //appBar: AppBar(toolbarHeight: 0),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
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
                      //stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Form(
                  key: myFormKey,
                  child: SafeArea(
                    child: CustomScrollView(
                      reverse: true,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 25, bottom: 5),
                                      child: Icon(
                                        Icons.pets,
                                        size: 120,
                                        color: Colors.green[100],
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
                                    InputEmail(emailController: _emailController),
                                    InputPassword(passwordController: _passwordController),
                                    //RememberMeButton(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              GoogleSigninButton(
                                text: '  Sign in with Google',
                                icon: FontAwesomeIcons.google,
                                onPressed: () {
                                  GoogleSignInService.signInWithGoogle();
                                  //GoogleSignInService.signOut();
                                },
                              ),
                              /*GoogleSigninButton(
                                text: '  Logout Google',
                                icon: FontAwesomeIcons.google,
                                onPressed: () {
                                  //GoogleSignInService.signInWithGoogle();
                                  GoogleSignInService.signOut();
                                },
                              ),*/
                              //_buildSocialBtnRow(),
                              const SizedBox(height: 20),
                              buildAlreadyHaveAccount(context),
                              _buildLoginBtn(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    final loginFormBloc = BlocProvider.of<LoginFormBloc>(context, listen: false);
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60, top: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          //Esconde el teclado
          FocusManager.instance.primaryFocus?.unfocus();

          if (!myFormKey.currentState!.validate()) {
            print('Formulario no valido');
            /*ScaffoldMessenger.of(context).showSnackBar(
              DialogHelper.modalBottomMessage(
                'Email o contraseña incorrectos',
                Colors.red.shade300,
              ),
            );*/
          } else {
            _emailController.text = _emailController.text.trim().toLowerCase();
            _passwordController.text = _passwordController.text.trim();

            print(_emailController.text);
            print(_passwordController.text);
            print(loginFormBloc.state.isRemember);

            DialogHelper.loadingModal(context);

            //Aqui voy a hacer el login a nuestro backend
            final dataLogin = await AuthService.signIn(_emailController.text, _passwordController.text);

            //Ocultar el loading
            Navigator.of(context).pop();

            //Controlamos que no haya habido ningun error en la peticion
            if (dataLogin["status_code"] == 400 || dataLogin["status_code"] == 401) {
              DialogHelper.modalBottom(context, dataLogin["message"],
                  dataLogin["status_code"] == 400 ? Colors.amber.shade600 : Colors.red.shade300);
            } else {
              final User userBackend = User.fromMap(dataLogin["user"]);

              //Le añado el api token al usuario
              userBackend.apiToken = dataLogin["access_token"];
              //Por el momento voy a guardar siempre el token
              Preferences.apiTokenBearer = dataLogin["access_token"];
              //Aqui voy a guardar en el telefono cierta información
              //Si el usuario quiere que lo recuerde guardo su apitoken
              if (loginFormBloc.state.isRemember) {
                Preferences.email = _emailController.text;
                Preferences.password = _passwordController.text;
              }

              //Añado a mi bloc el usuario que acabo de loguear
              BlocProvider.of<UserBloc>(context, listen: false).add(ActivateUser(userBackend));
              //Lo añado al bloc de editar usuario para editar datos y no modificar el original
              //Siempre le hago un reset a la propiedad del avatar por logica de nuestra app
              BlocProvider.of<EditUserBloc>(context, listen: false)
                  .add(EditUserEventSetState(newUser: userBackend.copyWith(avatar: 'null')));

              final notification =
                  await UserWishListServices.getNotification(apiToken: userBackend.apiToken!);
              BlocProvider.of<WishListBloc>(context)
                  .add(WishListEventLoadNotification(newWishListForm: notification));


              BlocProvider.of<UserFavouriteBloc>(context).add(UserFavouriteEventLoadData());
              BlocProvider.of<UserImagesBloc>(context).add(UserImagesEventLoadData());
              BlocProvider.of<MyPetsBloc>(context).add(MyPetsEventLoadData());

              Navigator.pushReplacementNamed(context, 'home');
            }
          }

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
            shape: const StadiumBorder()),
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  Widget buildAlreadyHaveAccount(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //Navegacion en modo ios
        /*Navigator.push(
            context,
            CupertinoPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );*/
        Navigator.pushReplacementNamed(context, 'register');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "No tienes cuenta? ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            'Registraté',
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
}

class RememberMeButton extends StatelessWidget {
  const RememberMeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormBloc = BlocProvider.of<LoginFormBloc>(context);
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
      ),
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: loginFormBloc.state.isRemember, //loginFormBloc.state.isRemember,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                loginFormBloc.add(AddLoginFormEvent(
                  loginFormBloc.state.email,
                  loginFormBloc.state.password,
                  !loginFormBloc.state.isRemember,
                  loginFormBloc.state.hidePassword,
                ));
              },
            ),
          ),
          const Text(
            'Recuerdame',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),

              // errorStyle: TextStyle(
              //     color: Colors.red,
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: 'Lato'),
            ),
            /*onChanged: (value) {
              formValues['email'] = value;
              print(formValues);
            },*/
            validator: ValidatorCustomHelper.validatorInputEmail,
          ),
        ],
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  final TextEditingController _passwordController;

  const InputPassword({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormBloc = BlocProvider.of<LoginFormBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
            obscureText: loginFormBloc.state.hidePassword,
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
                    loginFormBloc.add(AddLoginFormEvent(
                      loginFormBloc.state.email,
                      loginFormBloc.state.password,
                      loginFormBloc.state.isRemember,
                      !loginFormBloc.state.hidePassword,
                    ));
                  },
                  icon: Icon(
                    loginFormBloc.state.hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
              hintText: 'Introduce tu contraseña',
              hintStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
            ),
            /*onChanged: (value) {
              formValues['password'] = value;
              print(formValues);
            },*/
            validator: ValidatorCustomHelper.validatorInputPassword,
          ),
        ],
      ),
    );
  }
}
