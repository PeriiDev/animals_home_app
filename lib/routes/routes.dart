import 'package:adoptapet_app/adoptapet_package.dart';
import 'package:adoptapet_app/pages/profile_public.dart';

import '../pages/wish_list.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'splash': (BuildContext context) => LoginPage(),
    'home': (_) => const HomePage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => const RegisterPage(),
    'profile': (BuildContext context) => const ProfileUser(),
    'confirm_add_pet': (BuildContext context) => const ConfirmAddPet(),
    'edit_profile': (BuildContext context) => EditProfile(),
    'wish_list': (BuildContext context) =>  WishList(),
    'details_pet': (BuildContext context) => const DetailsPet(),
    'chats': (BuildContext context) => const ChatsPage(),
    'chat': (context) => ChatInsidePage(),
    'profile-public' :(context) => ProfilePublicUser(),
    //'preload':(context) => PreLoadPage(),
    
  };
}
