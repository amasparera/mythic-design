import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NothifLocal {
  final FlutterLocalNotificationsPlugin _nothif =
      FlutterLocalNotificationsPlugin();
  final onNothif = BehaviorSubject<String?>();

  Future init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _nothif.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        if (kDebugMode) {
          print("in payload $payload");
        }
        if (payload != null && payload.isNotEmpty) {
          onNothif.add(payload);
        }
      },
    );
  }

  Future<NotificationDetails> _notifdetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    return NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotif(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final detail = await _notifdetails();

    await _nothif.show(1, title, body, detail, payload: payload);
  }
}
