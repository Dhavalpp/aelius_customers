import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../models/user_model.dart';
import '../utils/shared_pref.dart';
import 'drop_down_menu.dart';

class NewServicesRequestDialog extends StatefulWidget {
  const NewServicesRequestDialog({super.key});

  @override
  State<NewServicesRequestDialog> createState() =>
      _NewServicesRequestDialogState();
}

class _NewServicesRequestDialogState extends State<NewServicesRequestDialog> {
  bool _isAccepted = false;
  UserModel? userModels;
  String customerCategoryArea = "";

  @override
  void initState() {
    super.initState();
    _isAccepted;
    customerCategoryArea;
    sharePreferenceData();
  }

  Future<dynamic> sharePreferenceData() async {
    UserModel? userData = await SharedPref().getSharedPreferences();
    setState(() {
      userModels = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if (!_isAccepted)
                Column(
                  children: [
                    Text("You are scheduling service request for... ",
                        style: TextStyle(
                          color: appData.isDark ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Container(
                        decoration: const BoxDecoration(),
                        child: DropDownMenu(
                          isregion: false,
                          gender: false,
                          oncategorySelected: categorySelected,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isAccepted = true;
                            });
                            _showNotification();
                            findnear(
                                customerCategoryArea,
                                userModels!.detail[0].pincode,
                                userModels!.detail[0].areaOfResidenceAdress);
                            notificationGenrate(
                                SharedPref().getFCMToken().toString());
                          },
                          child: const Text('ACCEPT'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              if (_isAccepted)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Nearest Services Provider Will Contact Soon....",
                      style: TextStyle(
                          fontSize: 20,
                          color: appData.isDark ? Colors.white : Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  void _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            "CustomerImmediate", "Your Services is Requested",
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        014,
        'Your Services is Requested',
        'Requested services of $customerCategoryArea',
        platformChannelSpecifics,
        payload: 'item x');
  }

  void categorySelected(String? selectedOptions) {
    selectedOptions = customerCategoryArea;
  }
}
