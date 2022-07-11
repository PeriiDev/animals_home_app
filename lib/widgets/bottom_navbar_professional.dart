// ignore_for_file: must_be_immutable

import 'package:adoptapet_app/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:adoptapet_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';

class ButtonNavigationBarProfessionalCustom extends StatelessWidget {
  Color? selectedColor;
  Color? backgroundColor;

  ButtonNavigationBarProfessionalCustom({
    Key? key,
    this.selectedColor = AppTheme.primary,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final bottomNavigationBloc = context.read<BottomNavigationBloc>();

    //Esta es la barra de navegacion inferior
    //Podemos envolverla en otros widget para por ejemplo conseguir border redodeados en las esquinas
    return Container(
      height: 65, //La altura de la barra de navegacion
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            //topRight: Radius.circular(10),
            //topLeft: Radius.circular(10),
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            //topLeft: Radius.circular(20),
            //topRight: Radius.circular(20),
            ),
        child: BlocBuilder<BottomNavigationBloc, int>(
          builder: (context, currentTabIndexState) {
            return BottomNavigationBar(
              elevation: 0,
              onTap: (index) {
                //Cambiamos el state del index de la barra de navegacion con PATRON BLOC
                bottomNavigationBloc.add(TabChangedEvent(index));
                /*context
                    .read<BottomNavigationBloc>()
                    .add(TabChangedEvent(index));*/
              },
              showUnselectedLabels: false,
              showSelectedLabels: true,
              selectedItemColor: selectedColor,
              backgroundColor: backgroundColor,
              currentIndex: currentTabIndexState,
              type: BottomNavigationBarType.fixed,
              //Muestro mas iconos o menos segun que cuenta este loguada
              items: userBloc.state.user?.rolId == 3 ? _buttonsUserAccount() : _buttonsAnimalAccount(),
            );
          },
        ),
      ),
    );
  }

  /*void _changePage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }*/

}

List<BottomNavigationBarItem> _buttonsAnimalAccount() {
  return const [
    //Boton del home
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(
        Icons.home,
        color: AppTheme.primary,
      ),
      label: 'Inicio',
    ),
    /* BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: '',
    ),*/

    BottomNavigationBarItem(
      icon: Icon(Icons.add_box),
      activeIcon: Icon(
        Icons.add_box,
        color: AppTheme.primary,
      ),
      label: 'Añadir',
    ),

    //Boton de ajustes
    /*BottomNavigationBarItem(
      icon: Icon(Icons.mark_chat_unread_outlined),
      activeIcon: Icon(Icons.mark_chat_unread),
      label: 'Chat',
    ),*/
    //Boton del perfil
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ];
}

List<BottomNavigationBarItem> _buttonsUserAccount() {
  return const [
    //Boton del home
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(
        Icons.home,
        color: AppTheme.primary,
      ),
      label: 'Inicio',
    ),
    /* BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: '',
    ),*/
    //Boton de ajustes
    /*BottomNavigationBarItem(
      icon: Icon(Icons.mark_chat_unread_outlined),
      activeIcon: Icon(Icons.mark_chat_unread),
      label: 'Chat',
    ),*/
    //Boton del perfil
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ];
}
