import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final bool gender;
  const DropDownMenu({super.key, required this.gender});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _selectedregionItem = 'Rajkot';
  final List<String> _dropDownregionItems = ['Rajkot', 'Ahmedabad', 'Surat', 'Baroda','Jamnagar','Junagadh','Morbi'];


  String _selectedItem = 'Male';
  final List<String> _dropDownItems = ['Male', 'Female', 'Transgender'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const  BoxDecoration(),
      child: widget.gender == false
          ? DropdownButton(
              value: _selectedregionItem,
              items: _dropDownregionItems
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              elevation: 3,
              onChanged: (value) {
                setState(() {
                  _selectedregionItem = value.toString();
                });
              },
            )
          : DropdownButton(
              value: _selectedItem,
              items: _dropDownItems
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              elevation: 3,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value.toString();
                });
              },
            ),
    );
  }
}
