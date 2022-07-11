import 'package:adoptapet_app/models/form_add_pet.dart';

import '../../adoptapet_package.dart';

part 'add_pet_event.dart';
part 'add_pet_state.dart';

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  AddPetBloc() : super(AddPetSetStateInitial()) {
    on<AddPetEventInitialState>(_onAddPetInitialState);

    on<AddPetEventSetState>(_onAddFormPet);

    /*on<ChangeParasites>((event, emit) {
      emit(AddPetSetState(
          state.formAddPet.copyWith(parasites: event.parasites)));
    });*/
  }

  void _onAddFormPet(AddPetEventSetState event, Emitter<AddPetState> emit) {
    emit(AddPetSetState(event.newFormAddPet));
  }

  void _onAddPetInitialState(AddPetEventInitialState event, Emitter<AddPetState> emit) {
    emit(AddPetSetStateInitial());
  }
}
