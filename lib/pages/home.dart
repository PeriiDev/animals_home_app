import 'package:adoptapet_app/adoptapet_package.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return BlocBuilder<BottomNavigationBloc, int>(
      builder: (context, currentTabBarIndex) {
        if (userBloc.state.existUser) {
          //Si existe el usuario y es una protectora
          if (userBloc.state.user?.rolId == 2 || userBloc.state.user?.rolId == 1) {
            switch (currentTabBarIndex) {
              case 0:
                return TabHomePage(userBloc: userBloc);
              case 1:
                return AddPet();
              case 2:
                return const ProfileUser();
              default:
                return TabHomePage(userBloc: userBloc);
            }
          }
          //Si el usuario logueado es un usuario normal
          if (userBloc.state.user?.rolId == 3) {
            switch (currentTabBarIndex) {
              case 0:
                return TabHomePage(userBloc: userBloc);
              case 1:
                return const ProfileUser();
              default:
                return TabHomePage(userBloc: userBloc);
            }
          }
        }
        return LoginPage();
      },
    );
  }
}
