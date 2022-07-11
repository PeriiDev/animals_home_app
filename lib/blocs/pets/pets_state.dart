part of 'pets_bloc.dart';

abstract class PetsState {
  int page;
  int lastPage;
  List<Pet> petsList;

  PetsState(
      {required this.page, required this.petsList, required this.lastPage});
}

class PetsSetStateInitial extends PetsState {
  PetsSetStateInitial() : super(petsList: [], page: 1, lastPage: 1);
}


class PetSetStateReloadData extends PetsState {
  int nextPageSet;
  int lastPageSet;
  List<Pet> petsListSet;
  PetSetStateReloadData({
    required this.nextPageSet,
    required this.petsListSet,
    required this.lastPageSet,
  }) : super(
          page: nextPageSet,
          petsList: petsListSet,
          lastPage: lastPageSet,
        );
}

class PetSetState extends PetsState {
  int nextPageSet;
  int lastPageSet;
  List<Pet> petsListSet;
  PetSetState({
    required this.nextPageSet,
    required this.petsListSet,
    required this.lastPageSet,
  }) : super(
          page: nextPageSet,
          petsList: petsListSet,
          lastPage: lastPageSet,
        );
}
