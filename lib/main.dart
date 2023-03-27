import 'package:aelius_customer/screens/splash_screen.dart';
import 'package:aelius_customer/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/my_scroll_behaviour.dart';
import 'store/appData.dart';
import 'utils/colors.dart';
import 'utils/constant.dart';

AppData appData = AppData();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // ...initialize settings...
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      // iOS: IOSInitializationSettings(),
    ),
  );
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print(message.data.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          scrollBehavior: MyScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: ThemeData.light().copyWith(
            colorScheme:const ColorScheme(
              brightness: Brightness.light,
              primary: primaryColor,
              onPrimary: whiteColor,
              secondary: secondaryColor,
              onSecondary: secondaryColor,
              error: redColor,
              onError: redColor,
              background: whiteColor,
              onBackground: whiteColor,
              surface: whiteColor,
              onSurface: blackColor,
            ),
            primaryColor: primaryColor,
            secondaryHeaderColor: whiteColor,
            iconTheme:const IconThemeData(color: primaryColor),
            tabBarTheme:const TabBarTheme(labelColor: Colors.black),
            listTileTheme:const ListTileThemeData(iconColor: blackColor),
            brightness: Brightness.light,
            dividerColor: transparent,
            appBarTheme:const AppBarTheme(
              iconTheme: IconThemeData(color: primaryColor),
              titleTextStyle: TextStyle(color: primaryColor),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: whiteColor,
              selectedItemColor: bottomSelectedColor,
              unselectedItemColor: bottomUnselectedColor,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme:const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.black,
              onPrimary: Colors.white,
              secondary: secondaryColor,
              onSecondary: secondaryColor,
              error: redColor,
              onError: redColor,
              background: whiteColor,
              onBackground: whiteColor,
              surface: greyColor,
              onSurface: blackColor,
            ),
            primaryColor: whiteColor,
            secondaryHeaderColor: primaryColor,
            iconTheme:const IconThemeData(color: whiteColor),
            brightness: Brightness.dark,
            tabBarTheme:const TabBarTheme(labelColor: Colors.white),
            listTileTheme:const ListTileThemeData(iconColor: whiteColor),
            dividerColor: transparent,
            dialogTheme:const DialogTheme(
              backgroundColor: Colors.grey,
              titleTextStyle: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              contentTextStyle: TextStyle(color: Colors.black),
            ),
            expansionTileTheme:const ExpansionTileThemeData(
                iconColor: whiteColor, textColor: whiteColor),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade500,
            ),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: whiteColor),
              titleTextStyle: TextStyle(color: whiteColor),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light),
            ),
          ),
          themeMode: appData.mode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
