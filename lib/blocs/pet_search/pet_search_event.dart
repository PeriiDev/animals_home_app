part of 'pet_search_bloc.dart';

abstract class PetSearchEvent extends Equatable {
  const PetSearchEvent();

  @override
  List<Object> get props => [];
}


class PetSearchSetState extends PetSearchEvent {
  final List<Pet> searchPetList;
  const PetSearchSetState({required this.searchPetList});

  @override
  List<Object> get props => [searchPetList];
}
