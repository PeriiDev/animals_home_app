import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/blocs/pet_info/pet_info_bloc.dart';
import 'package:adoptapet_app/blocs/profile_public_user/profile_public_user_bloc.dart';
import 'package:adoptapet_app/blocs/user_favourite/user_favourite_bloc.dart';
import 'package:adoptapet_app/models/pet_favourite.dart';
import 'package:adoptapet_app/services/user_favourites_services.dart';
import 'package:adoptapet_app/themes/app_theme.dart';
import 'package:adoptapet_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

import 'package:adoptapet_app/helpers/string_extension.dart';

import '../models/mini_user.dart';

const List<Color> masculineColor = [
  Color.fromARGB(255, 5, 58, 204),
  Color.fromARGB(255, 71, 176, 236),
];
const List<Color> femenineColor = [
  Color.fromARGB(255, 226, 91, 100),
  Color.fromARGB(255, 255, 146, 159),
];
/*const List<Color> availableColor = [
  AppTheme.primary,
  Color.fromARGB(255, 164, 212, 190),
];*/
const List<Color> availableColor = [
  Color.fromARGB(255, 142, 199, 118),
  Color.fromARGB(255, 178, 229, 156),
];
const List<Color> priorityColor = [
  Color.fromARGB(255, 212, 167, 101),
  Color.fromARGB(255, 243, 144, 15),
];
const List<Color> sizeColor = [
  Color.fromARGB(255, 186, 204, 23),
  Color.fromARGB(255, 216, 209, 116),
];

class DetailsPet extends StatelessWidget {
  const DetailsPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MiniUser? miniUser = ModalRoute.of(context)!.settings.arguments as MiniUser?;

    return BlocBuilder<PetInfoBloc, PetInfoState>(
      builder: (context, state) {
        print('Id del usuario de la mascota: ${state.petInfo!.userId}');
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _CustomAppBar(petInfoState: state),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _CustomBody(petInfoState: state, miniUser: miniUser!),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CustomBody extends StatelessWidget {
  final PetInfoState petInfoState;
  final MiniUser miniUser;
  const _CustomBody({
    Key? key,
    required this.petInfoState,
    required this.miniUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _CustomRowAttribute(
            typeAttribute: 'Nombre',
            valueAttribute: petInfoState.petInfo!.name,
          ),
          const SizedBox(
            height: 5,
          ),
          _CustomRowAttribute(
            typeAttribute: 'Color',
            valueAttribute: petInfoState.petInfo!.color,
          ),
          const SizedBox(
            height: 5,
          ),
          const _StateTitle(typeOne: 'Estado', typeTwo: 'Peso'),
          _StateBox(
            row: 1,
            valueOne: petInfoState.petInfo!.state,
            colorsListOne: availableColor,
            valueTwo: petInfoState.petInfo!.weight.toString(),
            colorsListTwo: sizeColor,
          ),
          const SizedBox(
            height: 15,
          ),
          const _StateTitle(typeOne: 'Tamaño', typeTwo: 'Sexo'),
          _StateBox(
              row: 2,
              valueOne: petInfoState.petInfo!.size,
              colorsListOne: masculineColor,
              valueTwo: petInfoState.petInfo!.sex,
              colorsListTwo: femenineColor),
          const SizedBox(
            height: 25,
          ),
          _CustomRowStatus(
            typeAttribute: 'Vacunado',
            imageIcon: 'assets/images/icons/inoculation.png',
            valueAttribute: petInfoState.petInfo!.inoculation,
          ),
          const SizedBox(
            height: 15,
          ),
          _CustomRowStatus(
            typeAttribute: 'Desparasitado',
            imageIcon: 'assets/images/icons/parasito.png',
            valueAttribute: petInfoState.petInfo!.parasites,
          ),
          const SizedBox(
            height: 15,
          ),
          _CustomRowStatus(
            typeAttribute: 'Castrado',
            imageIcon: 'assets/images/icons/infertile.png',
            valueAttribute: petInfoState.petInfo!.infertile,
          ),
          const SizedBox(
            height: 15,
          ),
          _CustomRowStatus(
            typeAttribute: 'Microchip',
            imageIcon: 'assets/images/icons/microchip.png',
            valueAttribute: petInfoState.petInfo!.microchip,
          ),
          const SizedBox(
            height: 25,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Descripción',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              petInfoState.petInfo!.description,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _CustomAccountDetails(idUser: petInfoState.petInfo!.userId, miniUser: miniUser),
        ],
      ),
    );
  }
}

class _StateBox extends StatelessWidget {
  final int row;
  final String valueOne;
  final List<Color> colorsListOne;
  final String valueTwo;
  final List<Color> colorsListTwo;

  const _StateBox({
    Key? key,
    required this.row,
    required this.valueOne,
    required this.colorsListOne,
    required this.valueTwo,
    required this.colorsListTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomContainer(
            //backgroundColor: Colors.green,
            child: Center(
              child: Text(
                valueOne.capitalize(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            borderColor: Colors.black,
            borderRadius: 12,
            borderWidth: 0.9,
            height: 50,
            backgroundColor: Colors.white,
            gradient: LinearGradient(
              colors: colorsListOne,
              /*[
                Color.fromARGB(255, 71, 176, 236),
                Color.fromARGB(255, 5, 58, 204),
              ],*/
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: CustomContainer(
            paddingHorizontal: 10,
            child: Center(
              child: Text(
                (row == 1) ? valueTwo.toString().capitalize() + " Kg" : valueTwo.toString().capitalize(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            borderColor: Colors.black,
            borderRadius: 12,
            borderWidth: 1.2,
            height: 50,
            backgroundColor: Colors.white,
            gradient: LinearGradient(
              colors: colorsListTwo,
              /*[
                Color.fromARGB(255, 212, 205, 101),
                Color.fromARGB(255, 141, 156, 5),
              ],*/
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        )
      ],
    );
  }
}

class _StateTitle extends StatelessWidget {
  final String typeOne;
  final String typeTwo;
  const _StateTitle({
    Key? key,
    required this.typeOne,
    required this.typeTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(typeOne, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        //const Spacer(),
        Expanded(
          child: Center(
            child: Text(
              typeTwo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class _CustomAccountDetails extends StatelessWidget {
  final int idUser;
  final MiniUser miniUser;
  _CustomAccountDetails({
    Key? key,
    required this.idUser,
    required this.miniUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        BlocProvider.of<ProfilePublicUserBloc>(context).add(ProfilePublicUserEventLoadData(idUser: idUser));
        Navigator.pushNamed(context, 'profile-public');
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 110, 109, 109),
                width: 0.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                CustomContainer(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: (miniUser.avatar != '' && miniUser.avatar != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image(
                              image: NetworkImage(API_STORAGE_USER + miniUser.avatar!),
                              fit: BoxFit.cover,
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
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomContainer(
                    //backgroundColor: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          miniUser.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          miniUser.description ?? 'Sin descripción',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        /*Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: availableColor,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enviar mensaje',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.paperPlane,
                                  size: 25,
                                ),
                                color: Color.fromARGB(255, 34, 33, 33),
                              ),
                            ],
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*Positioned(
            top: -5,
            child: IconButton(
              onPressed: () {},
              icon: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 117, 252),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FontAwesomeIcons.paperPlane,
                  size: 25,
                ),
              ),
            ),
          )*/
        ],
      ),
    );
  }
}

class _CustomRowStatus extends StatelessWidget {
  final String typeAttribute;
  final bool valueAttribute;
  final String imageIcon;

  const _CustomRowStatus({
    Key? key,
    required this.typeAttribute,
    required this.valueAttribute,
    required this.imageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imageIcon,
          height: 35,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(typeAttribute),
        const Spacer(),
        Image.asset(
          (valueAttribute) ? 'assets/images/icons/checkbox.png' : 'assets/images/icons/cancel.png',
          height: 35,
        ),
      ],
    );
  }
}

class _CustomRowAttribute extends StatelessWidget {
  final String typeAttribute;
  final String valueAttribute;

  const _CustomRowAttribute({
    Key? key,
    required this.typeAttribute,
    required this.valueAttribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          typeAttribute,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        //TODO REVISAR SI EL NOMBRE ES MUY GRANDE
        //const Spacer(),
        Expanded(
          child: Text(
            valueAttribute,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final PetInfoState petInfoState;
  const _CustomAppBar({
    Key? key,
    required this.petInfoState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      actions: [
        LikeButton(
          isLiked: petInfoState.isFavourite,
          likeCountPadding: const EdgeInsets.only(right: 10),
          size: 50,
          //animationDuration: const Duration(milliseconds: 1000),
          onTap: (value) async {
            if (value == false) {
              await UserFavouritesServices.addFavouritePet(
                idPet: petInfoState.petInfo!.id,
                ownerPetId: petInfoState.petInfo!.userId,
              );

              BlocProvider.of<PetInfoBloc>(context).add(PetInfoEventSetState(
                petInfoNew: petInfoState.petInfo!.copyWith(),
                isFavouriteNew: true,
              ));
              BlocProvider.of<UserFavouriteBloc>(context).add(UserFavouriteEventAddFavourite());
              return true;
            } else {
              await UserFavouritesServices.deleteFavouritePet(idPet: petInfoState.petInfo!.id);
              BlocProvider.of<PetInfoBloc>(context).add(PetInfoEventSetState(
                petInfoNew: petInfoState.petInfo!.copyWith(),
                isFavouriteNew: false,
              ));
              BlocProvider.of<UserFavouriteBloc>(context).add(UserFavouriteEventDeleteFavourite());
              return false;
            }
            //return false;
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        //title: Text('Detalles de la mascota'),
        centerTitle: true,
        background: Image(
          image: NetworkImage(API_STORAGE_PET + petInfoState.petInfo!.imageUrl),
          fit: BoxFit.cover,
        ), /*Image.asset(
          'assets/images/dog1.jpg',
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}
