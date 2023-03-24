import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class DropDownMenu extends StatefulWidget {
  final bool gender;

  const DropDownMenu({super.key, required this.gender});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _selectedregionItem = 'Rajkot';
  final List<String> _dropDownregionItems = [
    'Rajkot',
    'Ahmedabad',
    'Surat',
    'Baroda',
    'Jamnagar',
    'Junagadh',
    'Morbi'
  ];

  late List<Datum> category_list;
  String _selectedCategory = "plumber";

  String _selectedItem = 'Male';
  final List<String> _dropDownItems = ['Male', 'Female', 'Transgender'];

  Future<void> fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);
    setState(() {
      category_list = data.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategorie();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: widget.gender == false
          ? DropdownButton(
              // hint: const Text('Select a category'),
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue.toString();
                });
              },
              items: category_list.isNotEmpty
                  ? category_list.map((category) {
                      return DropdownMenuItem(
                        value: category.name,
                        child: Text(category.name),
                      );
                    }).toList()
                  : _dropDownItems
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
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
