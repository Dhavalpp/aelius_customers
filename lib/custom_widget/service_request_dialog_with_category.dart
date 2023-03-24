import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';
import 'drop_down_menu.dart';

class ServicesRequestDialogWithCategory extends StatefulWidget {
  bool nearestser;

  ServicesRequestDialogWithCategory({
    required this.nearestser,
    super.key,
  });

  @override
  State<ServicesRequestDialogWithCategory> createState() =>
      _ServicesRequestDialogWithCategoryState();
}

class _ServicesRequestDialogWithCategoryState
    extends State<ServicesRequestDialogWithCategory> {
  bool _isAccepted = false;

  late int _otp;

  // This method generates a random OTP.
  int _generateOTP() {
    return 1000 + Random().nextInt(9000);
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isAccepted;
  }

  Future<void> _selectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
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

  //
  // _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.white,
  //     context: context,
  //     elevation: 3,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: <Widget>[
  //           Text(
  //             "Best Services Provider Will Contact Soon....",
  //             style: TextStyle(
  //                 fontSize: 20,
  //                 color: appData.isDark ? Colors.white : Colors.black,
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.bold),
  //           )
  //         ],
  //       ).paddingAll(10.0);
  //     },
  //   );
  // }
  //
  // This method is called when the member clicks on the ACCEPT button.

  void _acceptRequest() {
    setState(() {
      _isAccepted = true;
      _otp = _generateOTP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        icon: const Icon(Icons.timer),
        title: _isAccepted == true
            ? const Text('SERVICE REQUESTED')
            : const Text('SERVICE REQUEST'),
        actions: [
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (!_isAccepted)
                Column(
                  children: [
                    Text("You are scheduling service " "request for... ",
                        style: TextStyle(
                          color: appData.isDark ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Container(
                        decoration: const BoxDecoration(),
                        child: const DropDownMenu(
                          gender: false,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Select Date :-  ",
                            style: TextStyle(
                              color:
                                  appData.isDark ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        MaterialButton(
                          onPressed: () => _selectDate(),
                          color: Colors.grey.shade100,
                          child: Text(
                              _selectedDate == null
                                  ? "Select Date"
                                  : "${_selectedDate.day} / ${_selectedDate.month} / ${_selectedDate.year}",
                              style: TextStyle(
                                  color: appData.isDark
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (widget.nearestser == false)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Select Time :-  ",
                                  style: TextStyle(
                                    color: appData.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              MaterialButton(
                                onPressed: () => _selectedTime(context),
                                color: Colors.grey.shade100,
                                child: Text(
                                    selectedTime == null
                                        ? "Select Time"
                                        : "${selectedTime.hour} : ${selectedTime.minute}",
                                    style: TextStyle(
                                        color: appData.isDark
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            maxLines: 5,
                            minLines: 1,
                            decoration:
                                InputDecoration(hintText: "Description"),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _acceptRequest,
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
                  children: [
                    const Text(
                      'Confirmation of service accepted by:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'so and so member',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'OTP: $_otp',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
