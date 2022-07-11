import 'adoptapet_package.dart';
import 'package:adoptapet_app/adoptapet_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  await PushNotificationService.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PetsBloc()..add(PetsEventReloadData())),
        BlocProvider(create: (_) => BottomNavigationBloc()),
        BlocProvider(create: (_) => LoginFormBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => EditUserBloc()),
        BlocProvider(create: (_) => AddPetBloc()),
        BlocProvider(create: (_) => WishListBloc()),
        BlocProvider(create: (_) => PetInfoBloc()),
        BlocProvider(create: (_) => UserFavouriteBloc()),
        BlocProvider(create: (_) => UserImagesBloc()),
        BlocProvider(create: (_) => MyPetsBloc()),
        BlocProvider(create: (_) => ProfilePublicUserBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    LocalNotificationServices.init();

    PushNotificationService.messageStream.listen((message) {
      if (message['type'] == "appIsOpen") {
        LocalNotificationServices.showNotification(
            title: 'Adopta Pet',
            body: 'Se ha registrado un animal en adopción que cumple con tus preferencias',
            id: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'AdoptaPet',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: messengerKey,
          routes: getAppRoutes(),
          initialRoute: 'login',
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
