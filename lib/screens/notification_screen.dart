import 'package:flutter/material.dart';

import '../custom_widget/notifiacation_member_profile.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Notification",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        padding:const EdgeInsets.all(8),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => NotificationMemberProfile(completed: index),
              ),
              child: Card(
                  color: appData.isDark ? cardColorDark : cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.ac_unit_sharp, size: 20),
                        const Space(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Home 2 House",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const Space(8),
                            Text(
                              "Thank you for order service using this app",
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
            ),
          );
        },
      ),
    );
  }
}
