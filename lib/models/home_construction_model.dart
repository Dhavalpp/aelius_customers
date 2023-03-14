import 'package:aelius_customer/utils/images.dart';
import 'package:flutter/material.dart';

import 'common_model.dart';

List<CommonModel> homeConstruction = getHomeConstruction();

List<CommonModel> getHomeConstruction() {
  List<CommonModel> homeConstruction = [];
  homeConstruction.add(CommonModel.withoutImage(
      "Construction", const Icon(Icons.construction, size: 35)));
  homeConstruction.add(CommonModel.withoutImage(
      "Architects", const Icon(Icons.architecture, size: 35)));
  homeConstruction.add(CommonModel.withoutImage(
      "Interior Design", const Icon(Icons.house_siding, size: 35)));
  homeConstruction.add(CommonModel.withoutImage(
      "Furniture", const Icon(Icons.vertical_split_rounded, size: 35)));

  return homeConstruction;
}

List<CommonModel> home2houseConstruction = getHome2houseConstruction();

List<CommonModel> getHome2houseConstruction() {
  List<CommonModel> home2houseConstruction = [];
  home2houseConstruction.add(CommonModel.withoutImage(
    "Painter",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_painter,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Cleaner",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_clean,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Electrician",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_electrcian,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Fridge Repair",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_fridge,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Plumber",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_plumber,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "AC Repair",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_ac_repair,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Kitchen",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_kitchen,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Carpenter",
    SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        c_carpenter,
        fit: BoxFit.contain,
      ),
    ),
  ));
  home2houseConstruction.add(CommonModel.withoutImage(
    "Home Cleaner",
    Image.asset(
      c_cleaner,
    ),
  ));

  return home2houseConstruction;
}
