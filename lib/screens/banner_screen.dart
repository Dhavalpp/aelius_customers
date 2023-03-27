import 'dart:async';

import 'package:aelius_customer/screens/dashboard_screen.dart';
import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:aelius_customer/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../models/banner_model.dart';
import '../utils/api_list.dart';
import '../utils/images.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  double screenHeight = 0.0;

  List<BannerModel> bannerlist = [];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() async {
        bool isLoggedIn = await SharedPref.isLoggedIn();
        if (isLoggedIn == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
          );
        }
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
              child: FutureBuilder<BannerModel>(
                  future: forntPageBanner(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FadeInImage(
                        image: NetworkImage(snapshot.data!.data[0].image),
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(banner),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
