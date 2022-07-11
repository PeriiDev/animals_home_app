import 'package:adoptapet_app/adoptapet_package.dart';

import '../widgets/custom_widgets.dart';

const List<String> _sexAnimals = ["Macho", "Hembra"];
const List<String> _sizeAnimals = ["Pequeño", "Mediano", "Grande"];

class WishList extends StatefulWidget {
  WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final GlobalKey<FormState> myKeyWishList = GlobalKey();

  late TextEditingController colorController;

  @override
  void initState() {
    colorController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*if (!Preferences.skipTutorial) {
      Future.delayed(Duration.zero, () => HelpersWidgets.displayTutorialScreen(context: context));
    }*/

    return BlocBuilder<WishListBloc, WishListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomBackButton(),
                  const SizedBox(height: 50),
                  (state.wishListForm.hasNotification)
                      ? _WishListNotification(
                          sizeValue: state.wishListForm.size,
                          colorValue: state.wishListForm.color,
                          sexValue: state.wishListForm.sex,
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/svg/wish_list_no.svg', height: 300),
                              Text(
                                  textAlign: TextAlign.center,
                                  'Vaya! Parece que aún no has registrado ninguna notificación')
                            ],
                          )),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: (state.wishListForm.hasNotification) ? Colors.red : AppTheme.primary,
            child: Icon(
              (state.wishListForm.hasNotification) ? FontAwesomeIcons.trash : FontAwesomeIcons.plus,
            ),
            onPressed: () {
              (!state.wishListForm.hasNotification)
                  ? showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: SingleChildScrollView(
                            child: Form(
                              key: myKeyWishList,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('*Sexo: '),
                                      const Spacer(), //Aplica espacio entre los elementos
                                      SizedBox(
                                        width: 130, //El ancho del seleccionable
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            fillColor: Colors.transparent,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: _sexAnimals
                                              .map(
                                                (sexAnimal) => DropdownMenuItem<String>(
                                                  child: Text(sexAnimal),
                                                  value: sexAnimal,
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (String? value) {
                                            BlocProvider.of<WishListBloc>(context).add(WishListEventSetState(
                                                newWishListForm: state.wishListForm.copyWith(sex: value)));
                                          },
                                          value: "Macho" /*state.formAddPet.sex*/,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('*Tamaño: '),
                                      const Spacer(), //Aplica espacio entre los elementos
                                      SizedBox(
                                        width: 130, //El ancho del seleccionable
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            fillColor: Colors.transparent,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: _sizeAnimals
                                              .map(
                                                (sizeAnimal) => DropdownMenuItem<String>(
                                                  child: Text(sizeAnimal),
                                                  value: sizeAnimal,
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (String? value) {
                                            BlocProvider.of<WishListBloc>(context).add(WishListEventSetState(
                                                newWishListForm: state.wishListForm.copyWith(size: value)));
                                          },
                                          value: "Pequeño" /*state.formAddPet.sex*/,
                                        ),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: colorController,
                                    enableSuggestions: true,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.transparent,
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppTheme.primary),
                                      ),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder: UnderlineInputBorder(),
                                      labelText: 'Color',
                                      labelStyle: TextStyle(
                                        color: AppTheme.primary,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                    validator: ValidatorCustomHelper.validatorDefault,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (!myKeyWishList.currentState!.validate()) {
                                          print('Formulario no valido');
                                        } else {
                                          //TODO LLAMAR A MI SERVICIO Y REGISTRAR NOTIFICACION
                                          //TODO CAMBIAR BANDERA A TRUE PARA CAMBIAR EL FLOATING ACTION BUTTON

                                          BlocProvider.of<WishListBloc>(context).add(WishListEventAdd(
                                              newWishListForm: state.wishListForm.copyWith(
                                            hasNotification: true,
                                            color: colorController.text.trim().toLowerCase(),
                                            sex: state.wishListForm.sex,
                                            size: state.wishListForm.size,
                                          )));

                                          //Limpio el controlador del valor anterior para que no salga en el formulario
                                          colorController.text = "";
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Activar alerta'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Borrar alerta'),
                          content: const Text('¿Estas seguro de que quieres borrar la alerta?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<WishListBloc>(context).add(WishListEventDelete(
                                  newWishListForm: state.wishListForm,
                                ));
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Borrar',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
            },
          ),
        );
      },
    );
  }
}

class _WishListNotification extends StatelessWidget {
  final String colorValue;
  final String sizeValue;
  final String sexValue;

  const _WishListNotification({
    Key? key,
    required this.colorValue,
    required this.sizeValue,
    required this.sexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomRowDataWishList(
            name: 'Tamaño: ',
            value: sizeValue,
            imageIcon: 'assets/images/icons/size.png',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRowDataWishList(
            name: 'Color: ',
            value: colorValue,
            imageIcon: 'assets/images/icons/color-palette.png',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRowDataWishList(
            name: 'Sex: ',
            value: sexValue,
            imageIcon: 'assets/images/icons/sex.png',
          ),
        ],
      ),
    );
  }
}

class CustomRowDataWishList extends StatelessWidget {
  final String name;
  final String value;
  final String imageIcon;

  const CustomRowDataWishList({
    Key? key,
    required this.name,
    required this.value,
    required this.imageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imageIcon,
          fit: BoxFit.contain,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
