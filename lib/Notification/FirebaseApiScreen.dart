import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseInAppMessaging firebaseInAppMessaging=FirebaseInAppMessaging.instance;

  Future<void> initNotification() async {

    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
    provisional: true,
    sound: true);
    final fcmToken = await firebaseMessaging.getToken();
    print("--------fcmToken---------${fcmToken}");

    FirebaseMessaging.onBackgroundMessage(Message);

  }

  Future<void> Message(RemoteMessage message) async {
    print('Title : ${message.notification?.title}');
    print('Body : ${message.notification?.body}');
    print('PayLoad : ${message.data}');
  }
}

//eWPEfapAQXO1Tj0Gi6-VLO:APA91bF2iTFuLra6jg8-xJHhBsNe_S6HRnsrr7mttuV4BManDKVWy5h_-gfwX96EgYGIr0TeTIOSiL-rzI22ryC23op9SYIrI_rGEvcxFir0AxSdRanEXBqTod2v2pLV8Ycs_KR7B7ih
