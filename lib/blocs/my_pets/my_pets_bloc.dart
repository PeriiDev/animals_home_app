import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/pet.dart';
import '../../services/pets_services.dart';

part 'my_pets_event.dart';
part 'my_pets_state.dart';

class MyPetsBloc extends Bloc<MyPetsEvent, MyPetsState> {
  MyPetsBloc() : super(MyPetsSetStateInitial()) {
    on<MyPetsEventLoadData>((event, emit) async {
      //TODO RECUPERAR TODAS LAS PETS QUE ME PERTENECEN
      final List<Pet> myPets = await PetServices.getMyPets();
      emit(MyPetsSetState(myPetsSet: myPets));
    });

    on<MyPetsEventInitialState>((event, emit) => emit(MyPetsSetStateInitial()));
  }
}
