import 'package:flutter/material.dart';
import '../models/last_bookings_model.dart';
import '../screens/dashboard_screen.dart';
import 'colors.dart';

InputDecoration commonInputDecoration(
    {String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}


Widget homeTitleWidget({
  String? titleText,
}) {
  return Padding(
    padding:const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText!,
            style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        // TextButton(
        //   child: Text(
        //     viewAllText ?? "View All",
        //     style: TextStyle(
        //         color: viewAllColor,
        //         fontSize: 16,
        //         fontWeight: FontWeight.normal),
        //   ),
        //   onPressed: onAllTap!,
        // ),
      ],
    ),
  );
}

Widget drawerWidget(
    {String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
  return ListTile(
    horizontalTitleGap: 0,
    visualDensity: VisualDensity.compact,
    leading: Icon(drawerIcon!, size: 20),
    title: Text(drawerTitle!, style: const TextStyle()),
    onTap: drawerOnTap!,
  );
}

Future<void> showAlertDialog(BuildContext context, {int? index}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:const Text('Are you sure to book that service again?'),
        actions: [
          TextButton(
            child:const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child:const Text('Yes'),
            onPressed: () {
              againBooking(index!);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>const DashBoardScreen()),
                      (route) => false);
            },
          ),
        ],
      );
    },
  );
}
