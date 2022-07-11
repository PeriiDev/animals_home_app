part of 'add_pet_bloc.dart';


abstract class AddPetState {
  FormAddPet formAddPet;
  AddPetState(this.formAddPet);
}

class AddPetSetStateInitial extends AddPetState {
  AddPetSetStateInitial()
      : super(FormAddPet(
          colorPet: "",
          description: "",
          imagePet: "",
          namePet: "",
          weight: 0.0,
          inoculation: false,
          parasites: false,
          infertile: false,
          microchip: false,
          birthdate: null,
          sex: "Macho",
          size: "Pequeño",
          state: "En adopción",
          typeAnimal: "Perro",
        ));
}

class AddPetSetState extends AddPetState {
  final FormAddPet formAddPetSet;

  AddPetSetState(this.formAddPetSet) : super(formAddPetSet);
}
