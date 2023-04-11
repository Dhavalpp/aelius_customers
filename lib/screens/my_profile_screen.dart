import 'dart:io';

import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/text_field_widget.dart';
import '../custom_widget/drop_down_menu.dart';
import '../custom_widget/space.dart';
import '../models/user_model.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import '../utils/shared_pref.dart';
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
  UserModel? userModels;

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sharePreferenceData();
  }

  Future<dynamic> sharePreferenceData() async {
    UserModel? userData = await SharedPref().getSharedPreferences();
    setState(() {
      userModels = userData;
    });
  }

  updateData(UserModel? userData) async {
    await SharedPref().setSharedPreferences(userData!);
  }

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
                    updateData(userModels);

                    if (customerEmail != "") {
                      updateData(userModels);
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoardScreen()),
                      (route) => false,
                    );
                  }));
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                      bottom: 3,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: boxDecorationWithRoundedCorners(
                          boxShape: BoxShape.circle,
                          backgroundColor: primaryColor,
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Icon(Icons.camera,
                            color: Colors.white, size: 20),
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
                text: userModels!.detail[0].fullName,
                onChanged: (name) {
                  customerName = name;
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: "Email",
                text: userModels!.detail[0].emailId,
                onChanged: (email) {
                  customerEmail = email;
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: "Phone No.",
                text: userModels!.detail[0].whatsappNumber.toString(),
                onChanged: (phone) {
                  customerMobile = phone;
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(_selectedDate == DateTime.now()
                              ? "${userModels!.detail[0].dateOfBirth.day}-${userModels!.detail[0].dateOfBirth.month}-${userModels!.detail[0].dateOfBirth.year}"
                              : "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}")),
                    ),
                    //     ElevatedButton(
                    //
                  ],
                ),
              ),
              const Space(15),
              backContainer(
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Area of Residence",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    DropDownMenu(
                      gender: true,
                      isregion: false,
                      // onOptionSelected: regionSelected,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: "Address",
                text: userModels!.detail[0].areaOfResidenceAdress,
                maxLines: 5,
                onChanged: (about) {
                  customerAddress = about;
                },
              ),
              const Space(15),
              backContainer(
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Area of Residence",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    DropDownMenu(
                      gender: false,
                      isregion: true,
                      // onOptionSelected: regionSelected,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  void genderSelected(String? selectedOption) {
    selectedOption = customerGender;
  }

  // void regionSelected(String? selectedOption) {
  //   selectedOption = customerResidancialArea;
  // }

  Container backContainer(
    Row rowcontainer,
  ) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: rowcontainer,
      ),
    );
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
