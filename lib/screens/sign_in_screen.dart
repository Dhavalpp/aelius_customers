// import 'package:country_calling_code_picker/picker.dart';
import 'package:aelius_customer/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/widget.dart';
import 'otp_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _smsController = TextEditingController();
  String? verificationIds;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  TextEditingController mobileNumber = TextEditingController();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  String? verificationId;

  // Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    // final country = await getDefaultCountry(context);
    // _selectedCountry = country;
    setState(() {});
  }

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

  // Future<void> _verifyPhoneNumber() async {
  //   final PhoneVerificationCompleted verificationCompleted =
  //       (AuthCredential phoneAuthCredential) async {
  //     await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (FirebaseAuthException authException) {
  //     print(
  //         'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  //   };

  //   final PhoneCodeSent codeSent =
  //       (String verificationId, [int? forceResendingToken]) {
  //     print('Please check your phone for the verification code.');
  //     this.verificationIds = verificationId;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     this.verificationIds = verificationId;
  //   };

  //   await _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: "+91" + mobileNumber.text,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: verificationCompleted,
  //     verificationFailed: verificationFailed,
  //     codeSent: codeSent,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //   );
  // }

  // void _showCountryPicker() async {
  //   final country = await showCountryPickerSheet(context);
  //   if (country != null) {
  //     setState(() {
  //       _selectedCountry = country;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              appData.isDark ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding:const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Space(35),
                  Text("Welcome to ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: mainTitleTextSize,
                        fontWeight: FontWeight.bold,
                      )),
                  const Space(10),
                  Image.asset(splash_logo,
                      width: 200, height: 200, fit: BoxFit.cover),
                  const Space(40),
                  Text("Please Login to your account",
                      style: TextStyle(fontSize: 14, color: subTitle)),
                ],
              ),
              const Space(10),
              Form(
                key: _loginFormKey,
                child: TextFormField(
                  controller: mobileNumber,
                  keyboardType: TextInputType.phone,
                  style:const TextStyle(fontSize: 16),
                  // validator: (value) {
                  //   if (value == null) {
                  //     return "Please Enter Your Phone Number";
                  //   } else if (value.length > 10 || value.length < 10) {
                  //     return "Please Enter Correct Mobile Number";
                  //   }
                  //   return null;
                  // },
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: commonInputDecoration(
                    hintText: "Enter mobile number",
                    // prefixIcon: Padding(
                    //   padding: EdgeInsets.all(16),
                    //   child: GestureDetector(
                    //     onTap: () => _showCountryPicker(),
                    //     child: Text(
                    //       _selectedCountry == null
                    //           ? "+91"
                    //           : _selectedCountry!.callingCode,
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
              const Space(16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:const EdgeInsets.all(16),
                    textStyle:const TextStyle(fontSize: 16),
                    shape:const StadiumBorder(),
                    backgroundColor: appData.isDark
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.black,
                  ),
                  onPressed: () async {
                    // _verifyPhoneNumber();
                    if (_loginFormKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPVerificationScreen(
                                verificationIds: verificationIds,
                                isLogin: true,
                                smsController: _smsController)),
                      );
                    }
                  },
                  child:const Text("Log In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ),
              ),
              const Space(22),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Divider(
              //               thickness: 1.2,
              //               color: Colors.grey.withOpacity(0.2))),
              //       Padding(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              //         child: Text("Or Login With",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 16)),
              //       ),
              //       Expanded(
              //           child: Divider(
              //               thickness: 1.2,
              //               color: Colors.grey.withOpacity(0.2))),
              //     ],
              //   ),
              // ),
              // Space(32),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(icGoogle,
              //         scale: 24,
              //         color: appData.isDark ? blackColor : blackColor),
              //     Space(40),
              //     Image.asset(icInstagram,
              //         scale: 24,
              //         color: appData.isDark ? blackColor : blackColor),
              //   ],
              // ),
              // Space(32),

              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    Space(4),
                    Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
