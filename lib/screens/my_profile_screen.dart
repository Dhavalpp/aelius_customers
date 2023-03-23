import 'package:aelius_customer/components/profile_widget.dart';
import 'package:flutter/material.dart';

import '../components/text_field_widget.dart';
import '../models/customer_details_model.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'dashboard_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String customerimage = "";
  String customerMobile = "";
  String customerName = "";
  String customerEmail = "";
  String dateofBirth = "";
  String customerGender = "";
  String customerAddress = "";
  String customerResidancialArea = "";
  String customerPincode = "";
  String customerAbout = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: const Text(
          "My Profile",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding:const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape:const StadiumBorder(),
              ),
              child:const Text("Save", style: TextStyle(fontSize: 16)),
              onPressed: () {
                if (customerName != "") {
                  setName(customerName);
                }
                if (customerEmail != "") {
                  setEmail(customerEmail);
                }
                if (customerAbout != "") {
                  setAbout(customerAbout);
                }
                setState(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardScreen()),
                    (route) => false,
                  );
                });
              },
            ),
          );
        },
        onClosing: () {},
      ),
      body: ListView(
        padding:const EdgeInsets.all(16),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          ProfileWidget(imagePath: userImage, onClicked: () {}),
          const SizedBox(height: 20),
          TextFieldWidget(
            label: "Full Name",
            text: getName,
            onChanged: (name) {
              customerName = name;
            },
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            label: "Email",
            text: getEmail,
            onChanged: (email) {
              customerEmail = email;
            },
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            label: "Phone No.",
            text: getPhone,
            onChanged: (phone) {
              customerEmail = phone;
            },
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            label: "Phone No.",
            text: getPhone,
            onChanged: (phone) {
              customerEmail = phone;
            },
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            label: "About",
            text: getAbout,
            maxLines: 5,
            onChanged: (about) {
              customerAbout = about;
            },
          ),
        ],
      ),
    );
  }
}
