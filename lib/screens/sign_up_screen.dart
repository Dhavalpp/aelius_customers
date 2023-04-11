import 'dart:io';
import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../custom_widget/drop_down_menu.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/widget.dart';
import 'otp_verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  String? token;

  SignUpScreen({Key? key, this.token}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _addressContainer = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final String gender = '';
  final String category = '';
  final String region = '';

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _refralCode = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool? agreeWithTeams = false;

  DateTime _selectedDate = DateTime.now();

  File? imageFile;
  XFile? pickedFile;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  File? _image;

  bool? checkBoxValue = false;
  String? verificationIds;

  String selectedValue = "IT";

  String countryCodeText = "+91";

  final countryPicker = const FlCountryCodePicker();
  final countryPickerWithParams = const FlCountryCodePicker(
    showDialCode: true,
    showSearchBar: true,
  );

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
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

  Future<void> _verifyPhoneNumber() async {
    verificationCompleted(AuthCredential phoneAuthCredential) async {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      // Do something after the user is signed in
    }

    verificationFailed(FirebaseAuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    }

    codeSent(String verificationId, [int? forceResendingToken]) {
      print('Please check your phone for the verification code.');
      this.verificationIds = verificationId;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              token: widget.token,
                  verificationIds: verificationIds,
                  isLogin: false,
                  smsController: _smsController,
                  mobileController: (_phoneController.text),
                  imagess: _image,
                  nameController: _nameController.text,
                  refrealController: _refralCode.text,
                  emailController: _emailController.text,
                  addressController: _addressContainer.text,
                  gender: gender,
                  region: region,
                  date:
                      "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}",
                )),
      );
    }

    codeAutoRetrievalTimeout(String verificationId) {
      this.verificationIds = verificationId;
    }

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: countryCodeText + _phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(children: const [
              Text('Please agree the terms and conditions')
            ]),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Space(42),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: mainTitleTextSize, fontWeight: FontWeight.bold),
                ),
              ),
              const Space(30),
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
                        height: 150,
                        width: 150,
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
                        child: const Icon(Icons.camera,
                            color: Colors.white, size: 25),
                      ).onTap(() async {
                        _showBottomSheet(context);
                      }),
                    )
                  ],
                ),
              ),
              const Space(16),
              Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 16),
                      decoration: commonInputDecoration(hintText: "Name"),
                    ),
                    const Space(16),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 20),
                      decoration: commonInputDecoration(hintText: "Email"),
                    ),
                    const Space(16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      style: const TextStyle(fontSize: 20),
                      decoration: commonInputDecoration(
                        hintText: "Mobile number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final code = await countryPicker.showPicker(
                                context: context,
                              );
                              if (code != null) {
                                setState(() {
                                  countryCodeText = code.dialCode;
                                });
                              }
                              // print(code.flagImage);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(countryCodeText,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Space(16),
                    backContainer(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Date of Birth",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: _selectDate,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: const Text("Select Date")),
                          )
                          //     ElevatedButton(
                          //
                        ],
                      ),
                    ),
                    const Space(16),
                    backContainer(Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        DropDownMenu(
                          gender: true,
                          isregion: false,
                          onGenderSelected: genderSelected,
                        ),
                      ],
                    )),
                    const Space(16),
                    TextFormField(
                      // maxLines: 3,
                      // expands: true,
                      controller: _addressContainer,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(fontSize: 20),
                      decoration: commonInputDecoration(
                        hintText: "Residence Address",
                      ),
                    ),
                    const Space(16),
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
                            onregionSelected: regionSelected,
                          ),
                        ],
                      ),
                    ),
                    const Space(16),
                    TextFormField(
                      controller: _refralCode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 20),
                      decoration:
                          commonInputDecoration(hintText: "Refral Code"),
                    ),
                    const Space(16),
                    Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              appData.isDark ? Colors.white : Colors.black),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: Colors.black,
                        title: const Text("I agree to the Terms and Conditions",
                            style: TextStyle(fontWeight: FontWeight.normal)),
                        value: agreeWithTeams,
                        dense: true,
                        onChanged: (newValue) {
                          setState(() {
                            agreeWithTeams = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    const Space(16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          textStyle: const TextStyle(fontSize: 25),
                          shape: const StadiumBorder(),
                          backgroundColor: appData.isDark
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.black,
                        ),
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            if (agreeWithTeams == true) {
                              _verifyPhoneNumber();
                            } else {
                              _showAlertDialog();
                            }
                          }
                        },
                        child: const Text("Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white)),
                      ),
                    ),
                    const Space(20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?",
                              style: TextStyle(fontSize: 16)),
                          Space(4),
                          Text('Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void genderSelected(String? selectedOption) {
    selectedOption = gender;
  }

  void regionSelected(String? selectedOption) {
    selectedOption = region;
  }

  // void categorySelected(String? selectedOption) {
  //   selectedOption = category;
  // }

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

  Container backContainer(
    Row rowcontainer,
  ) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: rowcontainer,
      ),
    );
  }
}
