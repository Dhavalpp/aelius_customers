import 'package:flutter/material.dart';

import '../models/electrician_services_provider_model.dart';

List<ElectricainServiceModel> electricainserviceProviders = getServices();

class ElectricainServiceModel {
  int id;
  String serviceName;
  IconData serviceIcon;
  List<ElectricainServiceProviderModel> electricainserviceProviders;
  bool isSelected;

  ElectricainServiceModel(
      this.id, this.serviceName, this.electricainserviceProviders, this.serviceIcon,
      {this.isSelected = false});
}

List<ElectricainServiceModel> getServices() {
  List<ElectricainServiceModel> list = List.empty(growable: true);
  list.add(ElectricainServiceModel(
      1, "House", getElectriciansforBuilder(), Icons.room_preferences_outlined,
      isSelected: true));
  list.add(ElectricainServiceModel(2, "Building", getElectriciansforHome(), Icons.home));
  list.add(
      ElectricainServiceModel(3, "Office", getElectriciansforIndustries(), Icons.sensor_occupied));
  list.add(ElectricainServiceModel(4, "Industries", getElectriciansforOffice(), Icons.report));

  return list;
}

void setLikedelec(int serviceIndex, int index) {
  if (electricainserviceProviders[serviceIndex].electricainserviceProviders[index].isLiked) {
    electricainserviceProviders[serviceIndex].electricainserviceProviders[index].isLiked = false;
    removeFavouriteelecProviderelec(serviceIndex, index);
  } else {
    electricainserviceProviders[serviceIndex].electricainserviceProviders[index].isLiked = true;
    addFavouriteProviderelec(serviceIndex, index);
  }
}
