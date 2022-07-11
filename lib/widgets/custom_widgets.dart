import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color borderColor;
  final double paddingVertical;
  final double paddingHorizontal;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  LinearGradient? gradient;
  Widget? child;

  CustomContainer(
      { this.child,
      this.width = 100,
      this.height = 100,
      this.borderWidth = 0,
      this.paddingHorizontal = 0,
      this.paddingVertical = 0,
      this.backgroundColor = Colors.transparent,
      this.borderColor = Colors.transparent,
      this.gradient,
      this.borderRadius = 0,
      this.marginBottom = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginTop = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: marginTop,
          bottom: marginBottom,
          left: marginLeft,
          right: marginRight),
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth),
          gradient: gradient),
      child: child,
    );
  }
}

class CustomInputText extends StatelessWidget {
  final String inputType; //Define que tipo de input construyo
  final String nameInput;
  final String hintTextInput;
  final TextEditingController? inputController;

  CustomInputText({
    Key? key,
    required this.inputType,
    this.inputController,
    this.nameInput = "",
    this.hintTextInput = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final addPetForm = BlocProvider.of<AddPetBloc>(context);
    return TextFormField(
      controller: inputController,
      enableSuggestions: true,
      autocorrect: false,
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),

        //contentPadding: const EdgeInsets.only(top: 14.0),
        labelText: nameInput,
        labelStyle: const TextStyle(
          color: Colors.red,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        hintText: hintTextInput,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
        // errorStyle: TextStyle(
        //     color: Colors.red,
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Lato'),
      ),
      onChanged: (value) {
        /*if (inputType == "name") {
          addPetForm.add(
            AddFormPetEvent(
              addPetForm.state.formAddPet.copyWith(namePet: value),
            ),
          );
        }
        if (inputType == "color") {
          addPetForm.add(
            AddFormPetEvent(
              addPetForm.state.formAddPet.copyWith(colorPet: value),
            ),
          );
        }
        if (inputType == "description") {
          addPetForm.add(
            AddFormPetEvent(
              addPetForm.state.formAddPet.copyWith(description: value),
            ),
          );
        }*/
      },
      //validator: ValidatorCustomHelper.validatorInputEmail,
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: const Icon(FontAwesomeIcons.arrowLeft),
          ),
        )
      ],
    );
  }
}



