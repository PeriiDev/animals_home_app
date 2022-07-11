import 'package:adoptapet_app/models/pet.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pet_search_event.dart';
part 'pet_search_state.dart';

class PetSearchBloc extends Bloc<PetSearchEvent, PetSearchState> {
  PetSearchBloc() : super(const PetSearchSetStateInitial()) {
    on<PetSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
