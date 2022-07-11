// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class ButtonNavigationBarCustom extends StatefulWidget {
  Color? selectedColor;
  Color? backgroundColor;
  int currentIndex;

  ButtonNavigationBarCustom(
      {Key? key,
      required this.currentIndex,
      this.selectedColor = Colors.black,
      this.backgroundColor = Colors.green})
      : super(key: key);

  @override
  State<ButtonNavigationBarCustom> createState() =>
      _ButtonNavigationBarCustomState();
}

class _ButtonNavigationBarCustomState extends State<ButtonNavigationBarCustom> {
  //Aqui metere las body de las distintas paginas
  //int _currentIndex = 1; //Indica la opcion de la barra selecionada
  @override
  Widget build(BuildContext context) {
    //Esta es la barra de navegacion inferior
    //Podemos envolverla en otros widget para por ejemplo conseguir border redodeados en las esquinas
    return Container(
      height: 60, //La altura de la barra de navegacion
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          onTap: _changePage,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: widget.selectedColor,
          backgroundColor: widget.backgroundColor,
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            //Boton del home
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            //Boton de favoritos
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              activeIcon: Icon(
                Icons.add,
              ),
              label: '',
            ),
            //Boton de ajustes
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: 'Chat',
            ),
            //Boton del perfil
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  void _changePage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }
}
