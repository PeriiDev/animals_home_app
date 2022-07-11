import 'dart:async';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/blocs/edit_user/edit_user_bloc.dart';
import 'package:adoptapet_app/blocs/my_pets/my_pets_bloc.dart';
import 'package:adoptapet_app/blocs/pets/pets_bloc.dart';
import 'package:adoptapet_app/blocs/user_favourite/user_favourite_bloc.dart';
import 'package:adoptapet_app/blocs/user_images/user_images_bloc.dart';
import 'package:adoptapet_app/models/mini_user.dart';
import 'package:adoptapet_app/models/pet_favourite.dart';
import 'package:adoptapet_app/models/user_image.dart';
import 'package:adoptapet_app/services/pets_services.dart';
import 'package:flutter/services.dart';

import '../blocs/pet_info/pet_info_bloc.dart';
import '../models/pet.dart';
import '../services/user_favourites_services.dart';
import '../services/user_services.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userFavoriteBloc = BlocProvider.of<UserFavouriteBloc>(context);

    //print('Longitud : ${userFavoriteBloc.state.favouriteListPet.length}');
    //final petsBloc = BlocProvider.of<PetsBloc>(context);

    print(userBloc.state.user);

    //return BlocBuilder<UserBloc, UserState>(
    //builder: (context, state) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          /*systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromARGB(255, 143, 143, 143)),*/
          //centerTitle: true,
          //backgroundColor: Colors.transparent,
          //elevation: 0,
          /* title: const Text(
                'Perfil',
                style: TextStyle(color: Colors.black),
              ),*/
          /* leading: Icon(
                Icons.person_add,
                color: Colors.black,
              ),*/
          /*actions: [
                GestureDetector(
                  onTap: () async {
                    //Aqui voy a desconectarme
                    //Primero voy a llamar el metodo logout para revokar los token de autenticacion
                    await AuthService.logout(userBloc.state.user!.apiToken);
                    userBloc.add(DeleteUserEvent());
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],*/
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    //TODO RESETEAR EL VALOR DE TODOS LOS BLOC
                    DialogHelper.loadingModal(context);
                    //Aqui voy a desconectarme
                    //Primero voy a llamar el metodo logout para revokar los token de autenticacion
                    await AuthService.logout(userBloc.state.user!.apiToken);
                    BlocProvider.of<UserImagesBloc>(context).add(UserImagesEventSetStateInitial());
                    BlocProvider.of<UserFavouriteBloc>(context).add(UserFavouriteEventSetStateInitial());
                    BlocProvider.of<MyPetsBloc>(context).add(MyPetsEventInitialState());
                    BlocProvider.of<AddPetBloc>(context).add(const AddPetEventInitialState());
                    BlocProvider.of<EditUserBloc>(context).add(EditUserEventInitial());

                    //Elimino al api token guardado en el telefono, ya no es valido
                    Preferences.apiTokenBearer = "";
                    Preferences.email = "";
                    Preferences.password = "";
                    BlocProvider.of<BottomNavigationBloc>(context).add(const TabChangedEvent(0));
                    userBloc.add(DeleteUserEvent());

                    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                    //Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 30, top: 20),
                    child: Icon(
                      Icons.logout,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Container(
                  child: (state.user!.avatar != null && state.user!.avatar != "null")
                      ? Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              API_STORAGE_USER + state.user!.avatar!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                        ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                userBloc.state.user?.name ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: const [
                            Text(
                              '37',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Siguiendo',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Seguidores',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: const [
                            Text(
                              '65',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              ' Likes ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),*/
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pushNamed(context, 'edit_profile'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: const Text(
                      'Editar perfil',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    HelpersWidgets.showGalleryOrCamera(context: context, type: 'profile');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                        size: 30,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pushNamed(context, 'wish_list');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      /*Icons.bookmark_border,*/
                      Icons.notifications,
                      color: Colors.grey[800],
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            //Descripcion de usuario aqui
            /*Text(
                  'Descripcion de usuario',
                  style: TextStyle(color: Colors.grey[700]),
                ),*/

            //Default tab controller

            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.images,
                    //Icons.grid_3x3,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.dog,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                ),
                /*Tab(
                                  icon: Icon(Icons.lock_outline_rounded, color: Colors.black),
                                ),*/
              ],
            ),

            //Tab bar view

            Expanded(
              child: TabBarView(
                children: [
                  BlocBuilder<UserImagesBloc, UserImagesState>(
                    builder: (context, state) {
                      return TabViewImageBook(
                        userImages: state.userImageList,
                      );
                    },
                  ),
                  BlocBuilder<MyPetsBloc, MyPetsState>(
                    builder: (context, state) {
                      return TabViewMyPets(
                        myPetsList: state.myPets,
                      );
                    },
                  ),
                  BlocBuilder<UserFavouriteBloc, UserFavouriteState>(
                    builder: (context, state) {
                      return TabViewFavourite(favouritePetsList: state.favouriteListPet);
                    },
                  )
                  //FirstTabView(color: Colors.green),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ButtonNavigationBarProfessionalCustom(),
      ),
    );
    //},
    //);
  }
}

class TabViewImageBook extends StatelessWidget {
  final List<UserImage> userImages;
  const TabViewImageBook({
    Key? key,
    required this.userImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: userImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              //Comprobar si la pet que vas a ver esta en favoritos
              /*final isFavourite = await UserFavouritesServices.isFavourite(userImages[index].petId);
              Pet? nextPagePet = await PetServices.getPet(idPet: userImages[index].petId);
              BlocProvider.of<PetInfoBloc>(context).add(
                PetInfoEventSetState(
                  petInfoNew: nextPagePet!,
                  isFavouriteNew: isFavourite,
                ),
              );
              Navigator.pushNamed(context, 'details_pet');*/
            },
            child: Container(
              child: Image.network(
                API_STORAGE_BOOK + userImages[index].imageGeneral,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

class TabViewFavourite extends StatelessWidget {
  final List<PetFavourite> favouritePetsList;
  const TabViewFavourite({
    Key? key,
    required this.favouritePetsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: favouritePetsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              DialogHelper.loadingModal(context);
              //Comprobar si la pet que vas a ver esta en favoritos
              final isFavourite = await UserFavouritesServices.isFavourite(favouritePetsList[index].petId);
              Pet? nextPagePet = await PetServices.getPet(idPet: favouritePetsList[index].petId);
              BlocProvider.of<PetInfoBloc>(context).add(
                PetInfoEventSetState(
                  petInfoNew: nextPagePet!,
                  isFavouriteNew: isFavourite,
                ),
              );
              print('Id usuario: ${favouritePetsList[index].userId}');
              final MiniUser? miniUser =
                  await UserServices.getMiniUser(idUser: favouritePetsList[index].ownerPetId);
              Navigator.pop(context);
              Navigator.pushNamed(context, 'details_pet', arguments: miniUser);
            },
            child: Container(
              child: Image.network(
                API_STORAGE_PET + favouritePetsList[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

class TabViewMyPets extends StatelessWidget {
  final List<Pet> myPetsList;
  const TabViewMyPets({
    Key? key,
    required this.myPetsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: myPetsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              DialogHelper.loadingModal(context);
              //Comprobar si la pet que vas a ver esta en favoritos
              final isFavourite = await UserFavouritesServices.isFavourite(myPetsList[index].id);
              Pet? nextPagePet = await PetServices.getPet(idPet: myPetsList[index].id);
              BlocProvider.of<PetInfoBloc>(context).add(
                PetInfoEventSetState(
                  petInfoNew: nextPagePet!,
                  isFavouriteNew: isFavourite,
                ),
              );
              final MiniUser? miniUser = await UserServices.getMiniUser(idUser: myPetsList[index].userId);
              Navigator.pop(context);
              Navigator.pushNamed(context, 'details_pet', arguments: miniUser);
            },
            child: Container(
              child: Image.network(
                API_STORAGE_PET + myPetsList[index].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
