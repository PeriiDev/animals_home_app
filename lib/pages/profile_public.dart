import 'dart:async';

import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/blocs/pets/pets_bloc.dart';
import 'package:adoptapet_app/blocs/profile_public_user/profile_public_user_bloc.dart';
import 'package:adoptapet_app/blocs/user_favourite/user_favourite_bloc.dart';
import 'package:adoptapet_app/models/pet_favourite.dart';
import 'package:adoptapet_app/services/pets_services.dart';
import 'package:flutter/services.dart';

import '../blocs/pet_info/pet_info_bloc.dart';
import '../models/pet.dart';
import '../models/user_image.dart';
import '../services/user_favourites_services.dart';

class ProfilePublicUser extends StatelessWidget {
  const ProfilePublicUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePublicUserBloc, ProfilePublicUserState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProfilePublicUserSetStateLoadData:
            return DefaultTabController(
              length: 1,
              child: Scaffold(
                appBar: AppBar(
                  /*systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromARGB(255, 143, 143, 143)),*/
                  centerTitle: true,
                  //backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Perfil público',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    const SizedBox(height: 25),
                    (state.user!.avatar != null)
                        ? SizedBox(
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        state.user?.name ?? 'Sin nombre',
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
                    //const SizedBox(height: 15),
                    /* Row(
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
                    Padding(
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
                ),*/

                    //Descripcion de usuario aqui
                    Text(
                      state.user!.description ?? 'Sin descripcion',
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    //Default tab controller
                    const SizedBox(height: 25),
                    const TabBar(
                      tabs: [
                        /*Tab(
                          icon: Icon(
                            Icons.grid_3x3,
                            color: Colors.black,
                          ),
                        ),*/
                        Tab(
                          icon: Icon(
                            FontAwesomeIcons.dog,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    //Tab bar view
                    Expanded(
                      child: TabBarView(
                        children: [
                          //TabViewImageBook(userImages: state.imagesList),
                          TabViewMyPets(myPetsList: state.imagesPets)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
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
            onTap: () {},
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
          child: Image.network(
            API_STORAGE_PET + myPetsList[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
