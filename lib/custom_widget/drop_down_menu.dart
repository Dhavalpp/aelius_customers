import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/region_model.dart';

class DropDownMenu extends StatefulWidget {
  final bool gender;
  final Function(String?)? onOptionSelected; // add this

  bool isregion;

  DropDownMenu(
      {super.key,
      required this.isregion,
      required this.gender,
      this.onOptionSelected});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _selectedregionItem = 'Rajkot';
  List<RegionDatum> dropDownregionItems = [
    // 'Rajkot',
    // 'Ahmedabad',
    // 'Surat',
    // 'Baroda',
    // 'Jamnagar',
    // 'Junagadh',
    // 'Morbi'
  ];

  List<CategoryDatum> categorylist = [];
  String _selectedCategory = "plumber";

  String _selectedItem = 'Male';
  final List<String> _dropDownItems = ['Male', 'Female', 'Transgender'];

  Future<void> fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);
    setState(() {
      categorylist = data.data;
    });
  }

  Future<void> fetchRegion() async {
    final response = await http.get(Uri.parse(regionUrl));
    final data = regionModelFromJson(response.body);
    setState(() {
      dropDownregionItems = data.data;
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
      child: widget.gender == false && widget.isregion == false
          ? DropdownButton(
              // hint: const Text('Select a category'),
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue.toString();
                });
                widget.onOptionSelected!(newValue);
              },
              items: categorylist.isNotEmpty
                  ? categorylist.map((category) {
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
          : widget.gender == false && widget.isregion == true
              ? DropdownButton(
                  // hint: const Text('Select a category'),
                  value: _selectedregionItem,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedregionItem = newValue.toString();
                    });
                    widget.onOptionSelected!(newValue);
                  },
                  items: dropDownregionItems.isNotEmpty
                      ? dropDownregionItems.map((category) {
                          return DropdownMenuItem(
                            value: category.regionTitle,
                            child: Text(category.regionTitle),
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
                    widget.onOptionSelected!(value);
                  },
                ),
    );
  }
}
