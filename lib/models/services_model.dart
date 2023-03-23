import 'package:aelius_customer/models/service_provider_model.dart';
import 'package:flutter/material.dart';

List<ServicesModel> serviceProviders = getServices();

class ServicesModel {
  int id;
  String serviceName;
  IconData serviceIcon;
  List<ServiceProviderModel> serviceProviders;
  bool isSelected;

  ServicesModel(
      this.id, this.serviceName, this.serviceProviders, this.serviceIcon,
      {this.isSelected = false});
}

List<ServicesModel> getServices() {
  List<ServicesModel> list = List.empty(growable: true);
  list.add(ServicesModel(
      1, "Room", getPlumbers(), Icons.room_preferences_outlined,
      isSelected: true));
  list.add(ServicesModel(2, "Building", getElectricians(), Icons.home));
  list.add(
      ServicesModel(3, "Occupation", getPainters(), Icons.sensor_occupied));
  list.add(ServicesModel(4, "Complains", getCarpenters(), Icons.report));

  return list;
}

void setLiked(int serviceIndex, int index) {
  if (serviceProviders[serviceIndex].serviceProviders[index].isLiked) {
    serviceProviders[serviceIndex].serviceProviders[index].isLiked = false;
    removeFavouriteProvider(serviceIndex, index);
  } else {
    serviceProviders[serviceIndex].serviceProviders[index].isLiked = true;
    addFavouriteProvider(serviceIndex, index);
  }
}
