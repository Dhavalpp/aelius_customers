import 'dart:async';

import 'package:aelius_customer/screens/dashboard_screen.dart';
import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:aelius_customer/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../models/banner_model.dart';
import '../utils/api_list.dart';
import '../utils/images.dart';

class BannerScreen extends StatefulWidget {
  String token;

  BannerScreen({super.key, required this.token});

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
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignInScreen(
                      token: widget.token,
                    )),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder<BannerModel>(
                future: forntPageBanner(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FadeInImage(
                      image: NetworkImage(
                          imagebannerURl + snapshot.data!.data[0].image),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(banner1),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
