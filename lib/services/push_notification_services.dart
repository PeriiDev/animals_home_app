import 'dart:async';

import 'package:adoptapet_app/settings/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final _messageStream = StreamController<Map<String, dynamic>>.broadcast();
  static Stream<Map<String, dynamic>> get messageStream => _messageStream.stream;

  //Cuando la app esta en segundo plano salta esto si mando la notificacion
  static Future _onBackgroundHandler(RemoteMessage message) async {
    _messageStream.add({"type": "appIsClose", "id_pet": 1, "message": message.data});
  }

  //Si la app esta abierta por el usuario y le llega una notificacion, salta esta opción
  static Future _onMessageHandler(RemoteMessage message) async {
    print('recibida');
    _messageStream.add({"type": "appIsOpen","id_pet": 1, "message": message.data});
  }

  //Cuando la app se abre salta este metodo si pulso la notificacion
  static Future _onMessageOpenApp(RemoteMessage message) async {

    _messageStream.add({"type": "appOpening","id_pet": 1, "message": message.data});
  }

  static Future initialize() async {

    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    Preferences.idDevicePushNotificationToken = token ?? 'Error al obtener el push notification id';

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }
}
