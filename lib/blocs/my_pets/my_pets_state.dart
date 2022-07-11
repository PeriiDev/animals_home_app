part of 'my_pets_bloc.dart';

abstract class MyPetsState {
  List<Pet> myPets;
  MyPetsState({required this.myPets});
}

class MyPetsSetStateInitial extends MyPetsState {
  MyPetsSetStateInitial() : super(myPets: []);
}

class MyPetsSetState extends MyPetsState {
  List<Pet> myPetsSet;
  MyPetsSetState({required this.myPetsSet}) : super(myPets: myPetsSet);
}
