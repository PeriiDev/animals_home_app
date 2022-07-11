import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/services/search_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/pet_info/pet_info_bloc.dart';
import '../../models/mini_user.dart';
import '../../models/pet.dart';
import '../../services/user_favourites_services.dart';
import '../../services/user_services.dart';

class SearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar...';

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
    //throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //Guardo la query que es la ultima busqueda realizada por este usuario
    if (!Preferences.lastSearch.contains(query) && query != '') {
      Preferences.setStringList = [...Preferences.lastSearch, query];
    }

    return FutureBuilder(
        future: SearchServices.searchPets(query),
        builder: (_, AsyncSnapshot snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 15),
                      child: Row(
                        children: const [
                          /*_FilterBox(filterType: 'Recientes', onTap: _onCustomTap),
                          SizedBox(width: 5),
                          _FilterBox(filterType: 'Sexo', onTap: _onCustomTap),
                          SizedBox(width: 5),
                          _FilterBox(filterType: 'Tamaño', onTap: _onCustomTap),
                          SizedBox(width: 5),
                          _FilterBox(filterType: 'Recientes', onTap: _onCustomTap),
                          SizedBox(width: 5),
                          _FilterBox(filterType: 'Sexo', onTap: _onCustomTap),
                          SizedBox(width: 5),
                          _FilterBox(filterType: 'Tamaño', onTap: _onCustomTap),
                          SizedBox(width: 5),*/
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, int index) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          _SuggestionItem(
                            pet: snapshot.data![index],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final petBloc = BlocProvider.of<>(context);
    if (query == '') {
      if (Preferences.lastSearch.isEmpty) {
        return const Center(
          child: Icon(
            FontAwesomeIcons.dog,
            color: Colors.black38,
            size: 100,
          ),
        );
      } else {
        //Tengo busquedas realizadas y la query esta vacia
        return ListView.builder(
            itemCount: Preferences.lastSearch.length,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () => query = Preferences.lastSearch[i],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListTile(
                    title: Text(
                      Preferences.lastSearch[i],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              );
            });
      }
    } else {
      return FutureBuilder(
          future: SearchServices.searchPets(query),
          builder: (_, AsyncSnapshot snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, int index) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      _SuggestionItem(
                        pet: snapshot.data![index],
                      ),
                    ],
                  );
                },
              );
            }

            return const Center(
              child: CupertinoActivityIndicator(),
            );
          });
    }
  }
}

class _FilterBox extends StatelessWidget {
  final String filterType;
  final void Function(BuildContext context)? onTap;

  const _FilterBox({
    Key? key,
    required this.filterType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            filterType,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _SuggestionItem extends StatelessWidget {
  final Pet pet;

  const _SuggestionItem({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/images/no-image.jpg'),
        image: NetworkImage(API_STORAGE_PET + pet.imageUrl),
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(pet.name),
      subtitle: Text(pet.description),
      onTap: () async {
        //DialogHelper.loadingModal(context);
        final isFavourite = await UserFavouritesServices.isFavourite(pet.id);
        //Puslo sobre el producto que quiero ver los detalles
        BlocProvider.of<PetInfoBloc>(context).add(PetInfoEventSetState(
          petInfoNew: pet,
          isFavouriteNew: isFavourite,
        ));
        final MiniUser? miniUser = await UserServices.getMiniUser(idUser: pet.userId);
        //Navigator.pop(context);
        Navigator.pushNamed(context, 'details_pet', arguments: miniUser);
        //productsController.asignProductDetail(pet);
        //Navigator.pushNamed(context, 'details');
      },
    );
  }
}

void Function()? _onCustomTap(BuildContext context) {
  showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.21,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.caretDown,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 40,
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                        title: Text(
                      'Macho',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
                const ListTile(
                    title: Text(
                  'Hembra',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ));
      });
}
