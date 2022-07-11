part of 'pet_info_bloc.dart';

abstract class PetInfoEvent extends Equatable {
  const PetInfoEvent();

  @override
  List<Object> get props => [];
}

class PetInfoEventSetState extends PetInfoEvent {
  final Pet petInfoNew;
  final bool isFavouriteNew;
  const PetInfoEventSetState({
    required this.petInfoNew,
    required this.isFavouriteNew,
  });

  @override
  List<Object> get props => [petInfoNew, isFavouriteNew];
}
