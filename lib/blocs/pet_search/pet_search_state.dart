part of 'pet_search_bloc.dart';

abstract class PetSearchState extends Equatable {
  final List<Pet> searchPetList;
  const PetSearchState({required this.searchPetList});

  @override
  List<Object> get props => [searchPetList];
}

class PetSearchSetStateInitial extends PetSearchState {
  const PetSearchSetStateInitial() : super(searchPetList: const []);
}
