import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'drop_down_menu.dart';

class NewServicesRequestDialog extends StatefulWidget {
  const NewServicesRequestDialog({super.key});

  @override
  State<NewServicesRequestDialog> createState() =>
      _NewServicesRequestDialogState();
}

class _NewServicesRequestDialogState extends State<NewServicesRequestDialog> {
  bool _isAccepted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isAccepted;
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
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            scheduleBooking("2", "doctor", "2023-08-22",
                                "11:00", "booking service");
                            _isAccepted = true;
                          },
                          child: const Text('ACCEPT'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // findnear(category_id, , region)
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
}
