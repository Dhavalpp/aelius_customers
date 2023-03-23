import 'dart:async';

import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../utils/images.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  double screenHeight = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: 0.9,
              duration: const Duration(milliseconds: 500),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Image.asset(
                    BannerScreenimage,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
