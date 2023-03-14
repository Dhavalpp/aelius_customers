import 'package:flutter/material.dart';
import 'dart:math';

class CustomOTPNotification extends StatefulWidget {
  const CustomOTPNotification({super.key});

  @override
  State<CustomOTPNotification> createState() => _CustomOTPNotificationState();
}

class _CustomOTPNotificationState extends State<CustomOTPNotification> {
  bool _isAccepted = false;
  late int _otp;

  int _generateOTP() {
    return 1000 + Random().nextInt(9000);
  }

  void _acceptRequest() {
    setState(() {
      _isAccepted = true;
      _otp = _generateOTP();
    });
  }


  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      actions: [
        Center(
          child: Text(
                        'Your OTP is 1520',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
        ),
    ),],);
  }
}
