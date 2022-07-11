/*import 'package:flutter/material.dart';

class InputTextField_My extends StatelessWidget {
  TextEditingController textController;

  const InputTextField_My({
    Key? key,
    TextEditingController textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: const InputDecoration(
        //contentPadding: const EdgeInsets.only(top: 14.0),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        hintText: 'Introduce tu e-mail',
        hintStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),

        // errorStyle: TextStyle(
        //     color: Colors.red,
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Lato'),
      ),
      onChanged: (value) {
        formValues['email'] = value;
        print(formValues);
      },
      validator: validatorInputEmail,
    );
  }
}*/
