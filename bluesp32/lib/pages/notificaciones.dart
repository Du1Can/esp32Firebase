import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('estaciones'); //Icon de la notificacion
    //esta en android/app/src/main/res/drawable/estaciones.png

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    final bool? initialized = await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Notificación recibida: ${details.payload}");
      },
    );

    if (initialized == null || !initialized) {
      print("Error al inicializar las notificaciones");
    } else {
      print("Servicio de notificaciones inicializado correctamente");
    }
  }

  static Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'bluetooth_channel',
      'Bluetooth Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'estaciones',
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}