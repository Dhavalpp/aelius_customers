import 'package:flutter/material.dart';
import '../components/category_booking_component.dart';
import '../main.dart';
import '../models/active_bookings_model.dart';
import '../utils/colors.dart';

class WorkPermission extends StatefulWidget {
  const WorkPermission({super.key});

  @override
  State<WorkPermission> createState() => _WorkPermissionState();
}

class _WorkPermissionState extends State<WorkPermission> {
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
                    ? const Center(
                        child: Text(
                        "No  Data",
                        style: TextStyle(color: Colors.black),
                      ))
                    : ListView.builder(
                        itemCount: activeBooking.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryBookingComponent(workprocess: "WorkPermission",
                              activeBookingsModel: activeBooking[index], index);
                        },
                      ),
    );
  }
}