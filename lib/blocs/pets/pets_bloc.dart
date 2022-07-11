import 'package:adoptapet_app/models/pet.dart';
import 'package:bloc/bloc.dart';

import '../../services/pets_services.dart';

part 'pets_event.dart';
part 'pets_state.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  PetsBloc() : super(PetsSetStateInitial()) {
    on<PetsEventInitialState>((event, emit) {
      emit(PetsSetStateInitial());
    });

    on<PetsEventReloadData>((event, emit) async {
      final dataPetMap = await PetServices.getAvailablePets(1);
      final List<dynamic> dataPetList = dataPetMap['pets'];
      final nextPage = ++dataPetMap["current_page"];
      final lastPage = dataPetMap["last_page"];
      final List<Pet> dataPetListConvert = [
        ...dataPetList.map((pet) => Pet.fromMap(pet)).toList()
      ];

      //final List<Pet> copy = [...state.petsList, ...event.petsList];

      emit(PetSetStateReloadData(
          petsListSet: dataPetListConvert,
          nextPageSet: nextPage,
          lastPageSet: lastPage));
    });
    on<PetsEventSetState>((event, emit) {
      final List<Pet> copy = [...state.petsList, ...event.petsList];
      emit(PetSetState(
          petsListSet: copy,
          nextPageSet: event.nextPage,
          lastPageSet: event.lastPageSet));
    });
  }
}
