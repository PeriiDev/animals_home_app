import 'package:adoptapet_app/blocs/edit_user/edit_user_bloc.dart';
import 'package:adoptapet_app/blocs/user_images/user_images_bloc.dart';
import 'package:adoptapet_app/services/pet_image_services.dart';
import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/services/user_images_services.dart';

class HelpersWidgets {
  static void displayTutorialScreen({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        elevation: 0,
        backgroundColor: const Color.fromARGB(225, 0, 0, 0),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          alignment: FractionalOffset.center,
          //padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, top: 20),
                      child: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              SvgPicture.asset(
                'assets/images/svg/push-notification.svg',
                height: 300,
              ),
              const Text(
                'Bienvenido a tu panel de notificaciones',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Puedes configurar tus gustos animaleros y nosotros no encargaremos de notificarte cuando alguna mascota coincida con tus gustos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        Preferences.skipTutorial = true;
                        Navigator.pop(context);
                      },
                      child: const Text('Entendido')))
            ],
          ),
        ),
      ),
    );
  }

  static void showGalleryOrCamera({required BuildContext context, required String type}) {
    final addPetForm = BlocProvider.of<AddPetBloc>(context);
    final editUserBloc = BlocProvider.of<EditUserBloc>(context);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width / 6,
          height: MediaQuery.of(context).size.height / 8,
          color: Colors.transparent,
          alignment: FractionalOffset.center,
          //padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 100,
                    );

                    print('RUTA DE LA IMAGEN: ${pickedFile?.path}');

                    if (pickedFile != null) {
                      print("Tenemos imagen  ${pickedFile.path}");
                      //final nameImageUpload = await ImageTestService.addImage({}, pickedFile.path);

                      //Cuando abro el pop up en la pagina "add_pet"
                      if (type == 'addpet') {
                        addPetForm.add(
                          AddPetEventSetState(
                            addPetForm.state.formAddPet.copyWith(imagePet: pickedFile.path),
                          ),
                        );
                      }
                      if (type == 'edituser') {
                        //File img = File(pickedFile.path);
                        editUserBloc.add(
                          EditUserEventSetState(
                            newUser: editUserBloc.state.user!.copyWith(avatar: pickedFile.path),
                          ),
                        );
                      }
                      if (type == 'profile') {
                        DialogHelper.loadingModal(context);
                        //La siguiente linea sube al servidor una imagen del usuario
                        await UserImagesServices.uploadUserImageGeneral(filepath: pickedFile.path);
                        BlocProvider.of<UserImagesBloc>(context).add(UserImagesEventLoadData());
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/icons/camara.png',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );

                    if (pickedFile != null) {
                      print("Tenemos imagen  ${pickedFile.path}");
                      if (type == 'addpet') {
                        addPetForm.add(
                          AddPetEventSetState(
                            addPetForm.state.formAddPet.copyWith(imagePet: pickedFile.path),
                          ),
                        );
                      }
                      if (type == 'edituser') {
                        editUserBloc.add(
                          EditUserEventSetState(
                            newUser: editUserBloc.state.user!.copyWith(avatar: pickedFile.path),
                          ),
                        );
                      }
                      if (type == 'profile') {
                        DialogHelper.loadingModal(context);
                        //La siguiente linea sube al servidor una imagen del usuario
                        await UserImagesServices.uploadUserImageGeneral(filepath: pickedFile.path);
                        BlocProvider.of<UserImagesBloc>(context).add(UserImagesEventLoadData());
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: const Image(
                      image: AssetImage('assets/images/icons/gallery.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*Image.file(File(listadoImagenes[index].path), fit: BoxFit.cover,)*/