import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/models/mini_user.dart';
import 'package:adoptapet_app/services/user_favourites_services.dart';
import 'package:adoptapet_app/services/user_services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../models/pet.dart';
import '../search/search_delegate.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({
    Key? key,
    required this.userBloc,
  }) : super(key: key);

  final UserBloc userBloc;

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            },
          ),
        ],
        //title: Text(userBloc.state.user?.email ?? ''),
      ),
      body: BlocBuilder<PetsBloc, PetsState>(
        builder: (context, state) {
          if (state is PetsSetStateInitial) {
           
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PetSetState) {
            print('ESTOY EN SET STATE');
          }

          print("numero de elemnto: ${state.petsList.length}");
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: LazyLoadScrollView(
              onEndOfPage: () async {
                if (state.page <= state.lastPage) {
                  //await Future.delayed(Duration(seconds: 3));
                  final dataPetMap = await PetServices.getAvailablePets(state.page);
                  final List<dynamic> dataPetList = dataPetMap['pets'];
                  final nextPage = ++dataPetMap["current_page"];
                  final List<Pet> dataPetListConvert = [
                    ...dataPetList.map((pet) => Pet.fromMap(pet)).toList()
                  ];

                  BlocProvider.of<PetsBloc>(context).add(PetsEventSetState(
                    nextPage: nextPage,
                    petsList: dataPetListConvert,
                    lastPageSet: state.lastPage,
                  ));

                  //Baja la pantalla del scroll hacia abajo
                  /*_scrollController.animateTo(
                      _scrollController.position.pixels + 120,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn);*/
                }
              },
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: GridView.builder(
                  itemCount: state.petsList.length,
                  physics: AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
                  itemBuilder: (context, index) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      DialogHelper.loadingModal(context);
                      //Comprobar si la pet que vas a ver esta en favoritos
                      final isFavourite = await UserFavouritesServices.isFavourite(state.petsList[index].id);
                      BlocProvider.of<PetInfoBloc>(context).add(
                        PetInfoEventSetState(
                          petInfoNew: state.petsList[index],
                          isFavouriteNew: isFavourite,
                        ),
                      );
                      final MiniUser? miniUser =
                          await UserServices.getMiniUser(idUser: state.petsList[index].userId);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'details_pet', arguments: miniUser);
                    },
                    child: AnimalCard(
                      imageUrl: API_STORAGE_PET + state.petsList[index].imageUrl,
                      nameAnimal: state.petsList[index].name,
                      idPet: state.petsList[index].id,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ButtonNavigationBarProfessionalCustom(),
    );
  }

  Future<void> onRefresh() async {
    BlocProvider.of<PetsBloc>(context).add(PetsEventReloadData());
    await Future.delayed(const Duration(seconds: 1));

  }
}

class _LoadingIconList extends StatelessWidget {
  const _LoadingIconList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: const CircularProgressIndicator(color: AppTheme.primary),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String imageUrl;
  final String nameAnimal;
  final int idPet;

  const AnimalCard({
    Key? key,
    required this.imageUrl,
    required this.nameAnimal,
    required this.idPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      shadowColor: AppTheme.primary.withOpacity(0.3),
      elevation: 6,
      child: Column(
        children: [
          FadeInImage(
            height: 147,
            width: double.infinity, //Toma todo el ancho posible
            fit: BoxFit.cover,
            //fadeInDuration: const Duration(milliseconds: 200),
            image: NetworkImage(
              imageUrl,
            ),
            placeholder: const AssetImage(
              'assets/images/icons/loading.gif',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, bottom: 0, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    //padding: const EdgeInsets.only(left: 6, top: 6, bottom: 0),
                    child: Center(
                      child: Text(
                        nameAnimal,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
