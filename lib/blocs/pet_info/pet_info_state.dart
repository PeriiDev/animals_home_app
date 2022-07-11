part of 'pet_info_bloc.dart';

@immutable
abstract class PetInfoState extends Equatable {
  final Pet? petInfo;
  final bool isFavourite;
  const PetInfoState({required this.petInfo, required this.isFavourite});

  @override
  List<Object> get props => [petInfo!, isFavourite];
}

class PetInfoSetStateInitial extends PetInfoState {
  const PetInfoSetStateInitial() : super(petInfo: null, isFavourite: false);
}

class PetInfoSetState extends PetInfoState {
  final Pet newPetInfo;
  final bool isFavouriteSet;
  const PetInfoSetState({required this.newPetInfo, required this.isFavouriteSet})
      : super(petInfo: newPetInfo, isFavourite: isFavouriteSet);

  @override
  List<Object> get props => [newPetInfo, isFavouriteSet];
}
