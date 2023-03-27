import 'dart:async';
import 'dart:io';

import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/api_list.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';
import 'dashboard_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  String? verificationIds;
  TextEditingController smsController;
  bool isLogin;
  String mobileController;
  String? nameController,
      emailController,
      addressController,
      region,
      gender,
      date,
      refrealController;

  File? imagess;

  OTPVerificationScreen(
      {Key? key,
      required this.verificationIds,
      required this.isLogin,
      this.imagess,
      required this.smsController,
      this.region,
      this.nameController,
      this.emailController,
      this.addressController,
      required this.mobileController,
      this.refrealController,
      this.gender,
      this.date})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String? _otpCode;
  final intRegex = RegExp(r'\d+', multiLine: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    // _getSignatureCode();
    // _startListeningSms();
  }


  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12);
  }

  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        widget.smsController.text = _otpCode!;
        _onOtpCallBack(_otpCode!, true);
      });
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });
    _signInWithPhoneNumber();
  }

  Future<void> _signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationIds!,
        smsCode: widget.smsController.text,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        if (widget.isLogin == true) {
          if (widget.mobileController != null) {
            login(widget.mobileController);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()),
            );
            await SharedPref.setLoggedIn(true);
          } else {
            showDialog(
              context: context,
              builder: (context) =>
                  Dialog(child: Text(widget.mobileController.toString())),
            );
          }
        } else {
          registerUser(
            widget.imagess!,
            widget.nameController!,
            widget.mobileController.toString(),
            widget.emailController!,
            widget.date!,
            widget.gender!,
            widget.addressController!,
            widget.region!,
            widget.refrealController!,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      } else {
        if (kDebugMode) {
          print('Error: Could not sign in.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
            IconThemeData(color: appData.isDark ? Colors.white : Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.35,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(
                        fontSize: mainTitleTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  const Space(16),
                  Text("We have sent OTP to your mobile number",
                      style: TextStyle(fontSize: 16, color: subTitle)),
                ],
              ),
            ),
            Form(
              key: _otpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldPin(
                      textController: widget.smsController,
                      autoFocus: true,
                      codeLength: _otpCodeLength,
                      alignment: MainAxisAlignment.center,
                      defaultBoxSize: 46.0,
                      margin: 3,
                      selectedBoxSize: 46.0,
                      textStyle: const TextStyle(fontSize: 16),
                      defaultDecoration: _pinPutDecoration.copyWith(
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8))),
                      selectedDecoration: _pinPutDecoration,
                      onChange: (code) {
                        _onOtpCallBack(code, false);
                      }),
                  const Space(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't receive OTP?",
                          style: TextStyle(fontSize: 16, color: subText)),
                      const Space(4),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: orangeColor),
                        ),
                      ),
                    ],
                  ),
                  const Space(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        textStyle: const TextStyle(fontSize: 25),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DashBoardScreen()),
                        //   );
                        // },
                        // _onSubmitOtp,
                        _signInWithPhoneNumber();
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
