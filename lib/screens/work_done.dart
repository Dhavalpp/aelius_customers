import 'package:flutter/material.dart';

import '../components/category_booking_component.dart';
import '../main.dart';
import '../models/active_bookings_model.dart';
import '../utils/colors.dart';
class WorkDone extends StatefulWidget {
  const WorkDone({super.key});

  @override
  State<WorkDone> createState() => _WorkDoneState();
}

class _WorkDoneState extends State<WorkDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
        IconThemeData(color: appData.isDark ? whiteColor : blackColor),
        title: Text(
          "Create New Post",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: appData.isDark ? whiteColor : blackColor),
        ),
      ),
      body: activeBooking.isEmpty
          ?const Center(
          child: Text(
            "No  Data",
            style: TextStyle(color: Colors.black),
          ))
          : ListView.builder(
        itemCount: activeBooking.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryBookingComponent(workprocess: "WorkDone",
              activeBookingsModel: activeBooking[index], index);
        },
      ),
    );
  }
}