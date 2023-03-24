import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

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

  DateTime _selectedDate = DateTime.now();

  File? imageFile;
  XFile? pickedFile;

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
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape: const StadiumBorder(),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 16)),
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
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  decoration: boxDecorationDefault(
                    border: Border.all(
                        color: context.scaffoldBackgroundColor, width: 4),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ).cornerRadiusWithClipRRect(100)
                        : const CircleAvatar(
                            backgroundImage: AssetImage(userImage),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: primaryColor,
                      border: Border.all(color: Colors.white),
                    ),
                    child:
                        const Icon(Icons.camera, color: Colors.white, size: 20),
                  ).onTap(() async {
                    _showBottomSheet(context);
                  }),
                )
              ],
            ),
          ),
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
          backContainer(
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date of Birth",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                TextButton(
                  onPressed: _selectDate,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(getPhone)),
                )
                //     ElevatedButton(
                //
              ],
            ),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: "Gallery",
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () {
                _getFromGallery();
                finish(context);
              },
            ),
            const Divider(),
            SettingItemWidget(
              title: "camera",
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  Container backContainer(
    Row rowcontainer,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: rowcontainer,
      ),
    );
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }
}
