import 'package:flutter/material.dart';

class GoogleSigninButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData icon;

  const GoogleSigninButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
      child: MaterialButton(
        splashColor: Colors.transparent,
        minWidth: double.infinity,
        height: 40,
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
