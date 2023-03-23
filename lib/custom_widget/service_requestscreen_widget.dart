import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../screens/order_summery_screen.dart';
class ServicesRequestScreenWidget extends StatefulWidget {
  int indexint;
  bool isfavorite;
  bool isbest;
  ServicesRequestScreenWidget(
      {super.key,
      required this.isbest,
      required this.indexint,
      required this.isfavorite});

  @override
  State<ServicesRequestScreenWidget> createState() =>
      _ServicesRequestScreenWidgetState();
}

class _ServicesRequestScreenWidgetState
    extends State<ServicesRequestScreenWidget> {
  bool _isAccepted = false;
  late int _otp;

  // This method generates a random OTP.
  int _generateOTP() {
    return 1000 + Random().nextInt(9000);
  }

  DateTime _selectedDate = DateTime.now();

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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      elevation: 3,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Best Services Provider Will Contact Soon....",
              style: TextStyle(
                  fontSize: 20,color:  appData.isDark ? Colors.white : Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            )
          ],
        ).paddingAll(10.0);
      },
    );
  }

  // This method is called when the member clicks on the ACCEPT button.
  void _acceptRequest() {
    setState(() {
      _isAccepted = true;
      _otp = _generateOTP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SERVICE REQUEST',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You are scheduling service request for',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              MaterialButton(
                onPressed: () => _selectDate(),
                color: Colors.grey.shade100,
                // ignore: unnecessary_null_comparison
                child: Text(_selectedDate == null
                    ? "Select Date"
                    : "${_selectedDate.day} / ${_selectedDate.month} / ${_selectedDate.year}",style: TextStyle(color:  appData.isDark ? Colors.white : Colors.black)),
              ),
              const SizedBox(height: 20),
              if (!_isAccepted)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _selectedDate.toString().isEmpty;
                        });
                        widget.isbest == false
                            ? 
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                           const OrderSummeryScreen(),
                        ),
                      )
                            : Container(
                                child: _showBottomSheet(context),
                              );
                        // _showBottomSheet;
                      },
                      child:const Text('ACCEPT'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedDate.toString().isEmpty;
                        });
                      },
                      child:const Text('Cancel'),
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
                      style:const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
