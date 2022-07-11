part of 'add_pet_bloc.dart';

abstract class AddPetEvent {
  const AddPetEvent();
}

class AddPetEventInitialState extends AddPetEvent {
  const AddPetEventInitialState();
}

class AddPetEventSetState extends AddPetEvent {
  final FormAddPet newFormAddPet;
  const AddPetEventSetState(this.newFormAddPet);
}


/*class ChangeParasites extends AddPetEvent {
  final bool parasites;
  const ChangeParasites(this.parasites);
}*/

