import 'dart:async';

import 'package:flutter/material.dart';

import '../services/notification_services.dart';
import '../utils/images.dart';
import 'banner_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
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
          MaterialPageRoute(builder: (context) => const BannerScreen()),
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
            width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }
}
