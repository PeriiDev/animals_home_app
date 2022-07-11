import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> myFormKey = GlobalKey();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _nameController = TextEditingController(text: BlocProvider.of<EditUserBloc>(context).state.user?.name);
    _phoneController = TextEditingController(text: BlocProvider.of<EditUserBloc>(context).state.user?.phone);
    _descriptionController =
        TextEditingController(text: BlocProvider.of<EditUserBloc>(context).state.user?.description);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editUserBloc = BlocProvider.of<EditUserBloc>(context);

    print('Edit user avatar ${editUserBloc.state.user?.avatar}');

    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: myFormKey,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 80,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                /*BlocProvider.of<EditUserBloc>(context).add(
                                  EditUserSetStateEvent(
                                      newUser: BlocProvider.of<UserBloc>(context).state.user),
                                );*/
                                BlocProvider.of<EditUserBloc>(context).add(EditUserEventSetState(
                                    newUser: BlocProvider.of<EditUserBloc>(context)
                                        .state
                                        .user!
                                        .copyWith(avatar: 'null')));

                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: const Icon(FontAwesomeIcons.arrowLeft),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                HelpersWidgets.showGalleryOrCamera(type: 'edituser', context: context);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: (state.user!.avatar != 'null')
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(60),
                                            child: Image.file(
                                              File(state.user!.avatar!),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  Positioned(
                                    bottom: 3,
                                    right: 3,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 187, 247, 189),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        _CustomInputEditProfile(
                          type: 'name',
                          controller: _nameController,
                          hintText: editUserBloc.state.user!.name,
                          keyboardType: TextInputType.name,
                        ),
                        _CustomInputEditProfile(
                          type: 'phone',
                          controller: _phoneController,
                          hintText: editUserBloc.state.user!.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        _CustomInputEditProfile(
                          type: 'description',
                          controller: _descriptionController,
                          hintText: editUserBloc.state.user!.description,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            await pickBirthDateUser(context);
                          },
                          child: TextFormField(
                            enabled: false,
                            //controller: _descriptionController,
                            enableSuggestions: true,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              enabledBorder: const UnderlineInputBorder(),
                              focusedBorder:
                                  const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),

                              //contentPadding: const EdgeInsets.only(top: 14.0),
                              label: (state.user!.birthdate == null)
                                  ? const Text('Fecha de nacimiento')
                                  : Text('Fecha nacimiento: ' +
                                      DateFormat('dd-MM-yyyy').format(state.user!.birthdate!)),
                              labelStyle: const TextStyle(
                                color: AppTheme.primary,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            //validator: ValidatorCustomHelper.validatorInputEmail,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 40,
                            //padding: const EdgeInsets.only(top: 50),
                            color: AppTheme.primary,
                            child: const Text(
                              'Modificar mis datos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (!myFormKey.currentState!.validate()) {
                                DialogHelper.modalBottom(
                                    context, 'La información no es correcta', Colors.red);
                              } else {
                                DialogHelper.loadingModal(context);
                                //Reinicio solo EL AVATAR del usuario en este bloc
                                editUserBloc.add(
                                  EditUserEventSetState(
                                    newUser: editUserBloc.state.user!.copyWith(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      description: _descriptionController.text,
                                      avatar: 'null',
                                    ),
                                  ),
                                );
                                //Como todo es correcto lo guardo en el bloc principañ
                                BlocProvider.of<UserBloc>(context).add(UserSetStateEvent(
                                  user: editUserBloc.state.user!.copyWith(
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    description: _descriptionController.text,
                                  ),
                                ));

                                BlocProvider.of<BottomNavigationBloc>(context).add(const TabChangedEvent(0));


                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                              }
                            },
                          ),
                        ),
                        /*ElevatedButton(
                            onPressed: () {}, child: Text('Aplicar cambios'))*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomInputEditProfile extends StatelessWidget {
  final String type;
  String? hintText;
  TextEditingController? controller;
  TextInputType? keyboardType;

  _CustomInputEditProfile({
    Key? key,
    required this.type,
    this.hintText,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: keyboardType,
      textCapitalization: (type == 'name' || type == 'description')
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //counter: Text('Telefono'),
        //counterText: 'Telefono',
        helperText: (type == 'name')
            ? 'Nombre'
            : (type == 'phone')
                ? 'Telefono'
                : 'Descripción',
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        errorBorder: const UnderlineInputBorder(),
        focusedErrorBorder: const UnderlineInputBorder(),

        //contentPadding: const EdgeInsets.only(top: 14.0),
        //labelText: 'Nombre',
        /*labelStyle: const TextStyle(
          color: AppTheme.primary,
          fontFamily: 'Poppins',
          fontSize: 16,
        ),*/

        //label: Text('peddro'),
        hintText: hintText,
        /*hintStyle: const TextStyle(
          color: AppTheme.primary,
          fontFamily: 'Poppins',
        ),*/
      ),
      validator: ValidatorCustomHelper.validatorDefault,
    );
  }
}

Future pickBirthDateUser(BuildContext context) async {
  final editUserBloc = BlocProvider.of<EditUserBloc>(context);
  final initialDate =
      (editUserBloc.state.user!.birthdate != null) ? editUserBloc.state.user!.birthdate : DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate!,
      firstDate: DateTime(DateTime.now().year - 120),
      lastDate: DateTime.now() /*DateTime(DateTime.now().year + 1)*/);

  if (newDate == null) return;

  //Año la fecha a bloc
  editUserBloc.add(EditUserEventSetState(newUser: editUserBloc.state.user!.copyWith(birthdate: newDate)));
}
