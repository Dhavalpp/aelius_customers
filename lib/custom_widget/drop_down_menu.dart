import 'package:aelius_customer/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/region_model.dart';
import '../models/user_model.dart';
import '../utils/shared_pref.dart';

class DropDownMenu extends StatefulWidget {
  final bool gender;
  final Function(String?)? oncategorySelected; // add this
  final Function(String?)? onregionSelected; // add this
  final Function(String?)? onGenderSelected; // add this

  bool isregion;

  DropDownMenu(
      {super.key,
      required this.isregion,
      required this.gender,
      this.oncategorySelected,
      this.onGenderSelected,
      this.onregionSelected});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  UserModel? userModels;
  String _selectedregionItem = 'punjab';
  List<RegionDatum> dropDownregionItems = [];

  List<CategoryDatum> categorylist = [];
  String selectedCategory = 'chef';

  String _selectedItem = 'Male';
  final List<String> _dropDownItems = ['Male', 'Female', 'Transgender'];

  // List<String> options = [];
  // String selectedOption;

  Future<dynamic> sharePreferenceData() async {
    UserModel? userData = await SharedPref().getSharedPreferences();
    setState(() {
      userModels = userData;
      print(userModels!.detail[0].fullName);
    });
  }

  Future<void> fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);
    setState(() {
      categorylist = data.data;
      if (kDebugMode) {
        print(data.data);
      }
      selectedCategory = data.data[0].name;
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
    super.initState();
    fetchCategorie();
    fetchRegion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: widget.gender == false && widget.isregion == false
          ? DropdownButton<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue.toString();
                });
                widget.oncategorySelected!(newValue);
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
        // hint: const Text('Select a Region'),
                  value: _selectedregionItem,
        onChanged: (newValues) {
                    setState(() {
                      _selectedregionItem = newValues.toString();
                    });
                    widget.onregionSelected!(newValues);
                  },
                  items: dropDownregionItems.isNotEmpty
                      ? dropDownregionItems.map((region) {
                          return DropdownMenuItem(
                            value: region.regionTitle,
                            child: Text(region.regionTitle),
                          );
                        }).toList()
                      : _dropDownItems
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                )
              : DropdownButton<String>(
                  value: _selectedItem,
                  hint: const Text('Select a Gender'),
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
                    widget.onGenderSelected!(value);
                  },
                ),
    );
  }
}
