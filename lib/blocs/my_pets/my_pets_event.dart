part of 'my_pets_bloc.dart';

abstract class MyPetsEvent {
  MyPetsEvent();
}

class MyPetsEventInitialState extends MyPetsEvent {
  MyPetsEventInitialState();
}

class MyPetsEventSetState extends MyPetsEvent {
  final List<Pet> newMyPets;
  MyPetsEventSetState({required this.newMyPets});
}

class MyPetsEventLoadData extends MyPetsEvent {
  MyPetsEventLoadData();
}
