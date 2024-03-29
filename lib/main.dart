import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:triwarna_rebuild/app/core/utils/configs/firebase_options.dart';
import 'package:triwarna_rebuild/app/core/utils/firebase_notif.dart';
import 'package:triwarna_rebuild/app/core/utils/local_notif.dart';
import 'package:triwarna_rebuild/app/core/values/colors.dart';
import 'package:triwarna_rebuild/app/routes/pages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final LocalNotif localNotif = LocalNotif();

  localNotif.showNotifications(
    id: message.notification.hashCode,
    title: message.notification?.title,
    body: message.notification?.body,
    payload: message.data.toString(),
    imageUrl: message.notification?.android?.imageUrl,
  );
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalNotif().init(); //
  await LocalNotif().requestIOSPermissions();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseNotif firebaseNotif = FirebaseNotif();

  firebaseNotif.firebaseInit();

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );

  Timer(const Duration(seconds: 1), () => FlutterNativeSplash.remove());

  initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Triwarna',
      theme: ThemeData(
        scaffoldBackgroundColor: baseBgScaffold,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purpleColor,
          primary: purpleColor,
        ),
        useMaterial3: true,
        fontFamily: 'Maison Neue',
      ),
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.full,
      defaultTransition: Transition.cupertino,
      initialRoute: '/',
      getPages: AppPages.pages,
    );
  }
}
