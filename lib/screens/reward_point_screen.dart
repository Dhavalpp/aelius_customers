import 'package:flutter/material.dart';
import '../custom_widget/reward_point.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';

class RewardPointScreen extends StatefulWidget {
  const RewardPointScreen({super.key});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen> {
  double screenHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
            IconThemeData(color: appData.isDark ? whiteColor : blackColor),
        title: Text(
          "Reward Point",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: appData.isDark ? whiteColor : blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RewardPoint(),
            const Divider(height: 15),
            const Text("History",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Divider(
              height: 8,
            ),
            SizedBox(
              height: screenHeight,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Card(
                        color: appData.isDark ? cardColorDark : cardColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.add_reaction_sharp, size: 20),
                              const Space(16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("XYZ Customer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Space(8),
                                  Text(
                                    "your account add 20 points",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: appData.isDark
                                          ? Colors.white70
                                          : Colors.grey.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
