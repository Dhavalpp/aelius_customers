import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../custom_widget/service_request_dialog_with_category.dart';
import '../main.dart';

class NewServicesRequestDialog extends StatefulWidget {
  const NewServicesRequestDialog

  ({super.key});

  @override
  State<NewServicesRequestDialog> createState() =>
      _NewServicesRequestDialogState();
}

class _NewServicesRequestDialogState extends State<NewServicesRequestDialog> {
   bool _isAccepted = false;

  String _selectedcategoryItem = "Painter";
  final List<String> _dropDowncategoryItems = [
    'Electrician',
    'Plumber',
    'Carpenter',
    'Painter',
    'AC Repair',
    'Cleaner'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isAccepted;
    _selectedcategoryItem;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Select Prefer Time...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Divider(height: 2,color: Colors.blueAccent,),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => immediateDialog(context),
                      );
                    },
                  ),
                  // Divider(height: 2,color: Colors.blueAccent),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            ServicesRequestDialogWithCategory(
                              nearestser: false,),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.deepPurple.shade300,
                      ),
                      child: btnText("Schedule", 15.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text btnText(String btntextString, double? btnTextsize) {
    return Text(
      btntextString,
      style: TextStyle(fontSize: btnTextsize == 0.0 ? 20.0 : btnTextsize),
    );
  }

   Dialog immediateDialog(BuildContext context) {
    // Navigator.pop(context);
    return Dialog(
      elevation: 0,
      child: SizedBox(
        height: 300,
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
                        child: DropdownButton(
                          value: _selectedcategoryItem,
                          items: _dropDowncategoryItems
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        elevation: 3,
                        onChanged: (values) {
                          setState(() {
                            _selectedcategoryItem = values.toString();
                          });
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isAccepted = true;
                          });
                        },
                        child:const Text('ACCEPT'),
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
            if(_isAccepted)
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

          ],),
        ),
      ),
    );

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
              "Nearest Services Provider Will Contact Soon....",
              style: TextStyle(
                  fontSize: 20,
                  color: appData.isDark ? Colors.white : Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            )
          ],
        ).paddingAll(10.0);
      },
    );
  }
}
