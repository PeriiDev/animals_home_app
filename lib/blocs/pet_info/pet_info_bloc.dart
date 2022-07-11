import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/pet.dart';

part 'pet_info_event.dart';
part 'pet_info_state.dart';

class PetInfoBloc extends Bloc<PetInfoEvent, PetInfoState> {
  PetInfoBloc() : super(const PetInfoSetStateInitial()) {
    on<PetInfoEventSetState>((event, emit) {
      emit(PetInfoSetState(newPetInfo: event.petInfoNew, isFavouriteSet: event.isFavouriteNew,));
    });
  }
}
