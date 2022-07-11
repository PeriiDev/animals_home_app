import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:intl/intl.dart';

const List<String> _typeAnimals = ["Perro", "Gato", "Otro"];
const List<String> _stateAnimals = ["En adopción", "Urgente"];
const List<String> _sexAnimals = ["Macho", "Hembra"];
const List<String> _sizeAnimals = ["Pequeño", "Mediano", "Grande"];

class AddPet extends StatefulWidget {
  AddPet({Key? key}) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _colorController;

  late TextEditingController _weightController;

  late TextEditingController _descriptionController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _colorController = TextEditingController();
    _weightController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _weightController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPetBloc, AddPetState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: myFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          HelpersWidgets.showGalleryOrCamera(type: 'addpet', context: context);
                        },
                        child: Stack(
                          children: [
                            _CustomPhotoSelec(),
                          ],
                        ),
                      ),
                      (BlocProvider.of<AddPetBloc>(context).state.formAddPet.imagePet == '')
                          ? Container(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: const Text(
                                'Tienes que añadir una foto',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 197, 55, 45),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Container(),
                      InputAddPet(
                        typeInput: "name",
                        nameController: _nameController,
                        nameInput: "*Nombre",
                        hintTextInput: "Introduce el nombre",
                      ),
                      InputAddPet(
                        typeInput: "color",
                        colorController: _colorController,
                        nameInput: "*Color",
                        hintTextInput: "Indica el color",
                      ),
                      InputAddPet(
                        typeInput: "weight",
                        weightController: _weightController,
                        nameInput: "Peso",
                        hintTextInput: "En kilogramos",
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('*Tipo de animal: '),
                          const Spacer(), //Aplica espacio entre los elementos
                          SizedBox(
                            width: 130, //El ancho del seleccionable
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              items: _typeAnimals
                                  .map(
                                    (typeAnimal) => DropdownMenuItem<String>(
                                      child: Text(typeAnimal),
                                      value: typeAnimal,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? value) {
                                BlocProvider.of<AddPetBloc>(context)
                                    .add(AddPetEventSetState(state.formAddPet.copyWith(typeAnimal: value)));
                              },
                              value: state.formAddPet.typeAnimal,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('*Estado: '),
                          const Spacer(), //Aplica espacio entre los elementos
                          Container(
                            width: 130, //El ancho del seleccionable
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              items: _stateAnimals
                                  .map(
                                    (stateAnimal) => DropdownMenuItem<String>(
                                      child: Text(stateAnimal),
                                      value: stateAnimal,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? value) {
                                BlocProvider.of<AddPetBloc>(context)
                                    .add(AddPetEventSetState(state.formAddPet.copyWith(state: value)));
                              },
                              value: state.formAddPet.state,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('*Sexo: '),
                          const Spacer(), //Aplica espacio entre los elementos
                          SizedBox(
                            width: 130, //El ancho del seleccionable
                            child: DropdownButtonFormField(
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
                                BlocProvider.of<AddPetBloc>(context)
                                    .add(AddPetEventSetState(state.formAddPet.copyWith(sex: value)));
                              },
                              value: state.formAddPet.sex,
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
                            child: DropdownButtonFormField(
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
                                BlocProvider.of<AddPetBloc>(context)
                                    .add(AddPetEventSetState(state.formAddPet.copyWith(size: value)));
                              },
                              value: state.formAddPet.size,
                            ),
                          )
                        ],
                      ),

                      // ignore: prefer_const_constructors
                      InputCheckBox(
                        nameCheckbox: "Vacunado",
                        imageCheckbox: "assets/images/icons/inoculation.png",
                      ),
                      //ignore: prefer_const_constructors
                      InputCheckBox(
                        nameCheckbox: "Desparasitado",
                        imageCheckbox: "assets/images/icons/parasito.png",
                      ),
                      //ignore: prefer_const_constructors
                      InputCheckBox(
                        nameCheckbox: "Esterilizado",
                        imageCheckbox: "assets/images/icons/infertile.png",
                      ),
                      //ignore: prefer_const_constructors
                      InputCheckBox(
                        nameCheckbox: "Microchip",
                        imageCheckbox: "assets/images/icons/microchip.png",
                      ),

                      InputAddPet(
                        typeInput: "description",
                        descriptionController: _descriptionController,
                        nameInput: "*Descripción",
                        hintTextInput: "Descripción",
                      ),

                      Align(
                        heightFactor: 2.5,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          //padding: const EdgeInsets.only(top: 50),
                          color: Colors.green.shade100,
                          child: (state.formAddPet.birthdate == null)
                              ? const Text('Elige la fecha de nacimiento')
                              : Text('Fecha nacimiento: ' +
                                  DateFormat('dd-MM-yyyy').format(state.formAddPet.birthdate!)),

                          onPressed: () async {
                            await pickDate(context);
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(bottom: 50, top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            child: const Text('Registrar adopcion'),
                            onPressed: () async {
                              if (myFormKey.currentState!.validate()) {
                                if (BlocProvider.of<AddPetBloc>(context).state.formAddPet.imagePet != '') {
                                  //await DialogHelper.loadingModalFuture(context: context, milliseconds: 1500);
                                  DialogHelper.loadingModal(context);
                                  //TODO SERVICIO POST REGISTRAR MASCOTA
                                  final mapNewPet = await PetServices.addPet(newPet: state.formAddPet);
                                  final idNewPet = mapNewPet['pet']['id'];
                                  //print('Id nueva pet; $idNewPet');
                                  final a = await PetImageService.addImage(
                                      {"pet_id": idNewPet.toString()}, state.formAddPet.imagePet);
                                  //print(a);
                                  //TODO HACER RESET DEL ADD PET BLOC
                                  BlocProvider.of<AddPetBloc>(context).add(AddPetEventInitialState());

                                  //TODO HAGO UN RELOAD DE MIS MASCOTAS PARA EL PROFILE
                                  BlocProvider.of<MyPetsBloc>(context).add(MyPetsEventLoadData());

                                  //TODO SERVICIO DE PUSH NOTIFICATION
                                  await NotificationsService.sendPushNotifications(
                                    color: _colorController.text.trim().toLowerCase(),
                                    size: state.formAddPet.size,
                                    sex: state.formAddPet.sex,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, 'confirm_add_pet');
                                } else {}
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: ButtonNavigationBarProfessionalCustom(),
        );
      },
    );
  }
}

class _CustomPhotoSelec extends StatelessWidget {
  const _CustomPhotoSelec({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: (BlocProvider.of<AddPetBloc>(context).state.formAddPet.imagePet == '')
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const FadeInImage(
                width: double.infinity, //Toma todo el ancho posible
                image: AssetImage(
                  'assets/images/placeholder.jpg',
                ),
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  'assets/images/placeholder.jpg',
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(BlocProvider.of<AddPetBloc>(context).state.formAddPet.imagePet),
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}

class InputCheckBox extends StatelessWidget {
  final String nameCheckbox;
  final String imageCheckbox;

  const InputCheckBox({
    Key? key,
    required this.imageCheckbox,
    required this.nameCheckbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addPetForm = BlocProvider.of<AddPetBloc>(context);
    return CheckboxListTile(
      value: (nameCheckbox == "Vacunado")
          ? addPetForm.state.formAddPet.inoculation
          : (nameCheckbox == "Desparasitado")
              ? addPetForm.state.formAddPet.parasites
              : (nameCheckbox == "Esterilizado")
                  ? addPetForm.state.formAddPet.infertile
                  : addPetForm.state.formAddPet.microchip,
      title: Text(nameCheckbox),
      activeColor: Colors.green,
      checkColor: Colors.white,
      tileColor: Colors.transparent,
      secondary: Image.asset(
        imageCheckbox,
        width: 30,
      ),
      onChanged: (value) {
        //Vamos a controlar en que checkbox estoy
        if (nameCheckbox == "Vacunado") {
          addPetForm.add(AddPetEventSetState(addPetForm.state.formAddPet.copyWith(inoculation: value)));
        }
        if (nameCheckbox == "Desparasitado") {
          addPetForm.add(AddPetEventSetState(addPetForm.state.formAddPet.copyWith(parasites: value)));
        }
        if (nameCheckbox == "Esterilizado") {
          addPetForm.add(AddPetEventSetState(addPetForm.state.formAddPet.copyWith(infertile: value)));
        }
        if (nameCheckbox == "Microchip") {
          addPetForm.add(AddPetEventSetState(addPetForm.state.formAddPet.copyWith(microchip: value)));
        }
      },
    );
  }
}

class InputAddPet extends StatelessWidget {
  final String typeInput; //Define que tipo de input construyo
  final String nameInput;
  final String hintTextInput;
  final TextEditingController? colorController;
  final TextEditingController? nameController;
  final TextEditingController? descriptionController;
  final TextEditingController? weightController;

  InputAddPet({
    Key? key,
    required this.typeInput,
    this.descriptionController,
    this.nameController,
    this.colorController,
    this.weightController,
    this.nameInput = "",
    this.hintTextInput = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addPetForm = BlocProvider.of<AddPetBloc>(context);
    return TextFormField(
      controller: (typeInput == "name")
          ? nameController
          : (typeInput == "description")
              ? descriptionController
              : (typeInput == "weight")
                  ? weightController
                  : colorController,
      enableSuggestions: true,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: (typeInput == 'weight') ? TextInputType.number : TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),

        //contentPadding: const EdgeInsets.only(top: 14.0),
        labelText: nameInput,
        labelStyle: const TextStyle(
          color: AppTheme.primary,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        hintText: hintTextInput,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
        errorBorder: UnderlineInputBorder(),
        focusedErrorBorder: UnderlineInputBorder(),
        // errorStyle: TextStyle(
        //     color: Colors.red,
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Lato'),
      ),
      onChanged: (value) {
        if (typeInput == "name") {
          addPetForm.add(
            AddPetEventSetState(
              addPetForm.state.formAddPet.copyWith(namePet: value),
            ),
          );
        }
        if (typeInput == "color") {
          addPetForm.add(
            AddPetEventSetState(
              addPetForm.state.formAddPet.copyWith(colorPet: value.toLowerCase()),
            ),
          );
        }
        if (typeInput == "weight") {
          addPetForm.add(
            AddPetEventSetState(
              addPetForm.state.formAddPet.copyWith(weight: double.parse(value)),
            ),
          );
        }
        if (typeInput == "description") {
          addPetForm.add(
            AddPetEventSetState(
              addPetForm.state.formAddPet.copyWith(description: value),
            ),
          );
        }
      },
      validator: (typeInput == "weight")
          ? ValidatorCustomHelper.validatorNumberic
          : ValidatorCustomHelper.validatorDefault,
    );
  }
}

class PhotoTest extends StatelessWidget {
  const PhotoTest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        child: Icon(Icons.photo_camera),
        onPressed: () async {
          final picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 100,
          );

          if (pickedFile == null) {
            print("No selecciono nada");
          }

          print("Tenemos imagen  ${pickedFile?.path}");
        },
      ),
    );
  }
}

Future pickDate(BuildContext context) async {
  final addPetForm = BlocProvider.of<AddPetBloc>(context);
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime.now() /*DateTime(DateTime.now().year + 1)*/);

  if (newDate == null) return;

  //Año la fecha a bloc
  addPetForm.add(AddPetEventSetState(addPetForm.state.formAddPet.copyWith(birthdate: newDate)));
}
