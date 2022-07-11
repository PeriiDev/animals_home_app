import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF00C569);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Poppins',
        ),
    //Color primario

    primaryColor: const Color(0xFF00C569),

    tabBarTheme: const TabBarTheme(labelColor: primary),
    //AppBar theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    //TextButton theme
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),

    //FloatingActionsButtons
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary, elevation: 5),

    //ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: const Color(0xFF00C569),
            shape: const StadiumBorder(),
            elevation: 0)),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,

      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xffE5E5E5),
        ),
      ),

      //Border del input cuando no tiene foco ni tiene error - Estado por defecto
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
      //Border del input cuando tiene foco
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF1B5E20),
          width: 3,
        ),
      ),

      //Border el input cuando tiene error, las lineas seran rojas
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          width: 3,
          color: Colors.red,
        ),
      ),

      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          )),

      errorStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Lato'),

      //floatingLabelStyle: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.amber,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    //TextButton theme
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),

    //FloatingActionsButtons
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary, elevation: 5),
    // Input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.2,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),

      //floatingLabelStyle: TextStyle(color: Colors.black),
      /*focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            //color: Colors.black,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
        ),*/

      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),
    ),
  );
}
