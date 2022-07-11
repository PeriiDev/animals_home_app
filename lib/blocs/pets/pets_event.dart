part of 'pets_bloc.dart';

abstract class PetsEvent {
  PetsEvent();
}

class PetsEventInitialState extends PetsEvent {
  PetsEventInitialState();
}

class PetsEventReloadData extends PetsEvent {
  PetsEventReloadData();
}

class PetsEventSetState extends PetsEvent {
  int nextPage;
  int lastPageSet;
  final List<Pet> petsList;
  PetsEventSetState({required this.nextPage, required this.petsList, required this.lastPageSet});
}


