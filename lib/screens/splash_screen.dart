import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/notification_services.dart';
import '../utils/images.dart';
import '../utils/shared_pref.dart';
import 'banner_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  String token = '';
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    NotificationServices().requestNotificationPermission();
    NotificationServices().setupInteractMessage(context);
    NotificationServices().firebaseInit(context);
    NotificationServices().getDeviceToken().then((value) {
      SharedPref().storeFCMToken(value);
      token = value;
      print(value);
      print('device token');
      print(value);
    });
    init();
  }

  void init() async {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => BannerScreen(
                    token: token,
                  )),
          (route) => false,
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(splash_logo,
            width: 300, height: 300, fit: BoxFit.cover),
      ),
    );
  }
}
