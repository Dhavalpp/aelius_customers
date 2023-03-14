import 'package:aelius_customer/models/provider_services_model.dart';
import 'package:aelius_customer/models/services_model.dart';
import 'package:aelius_customer/utils/images.dart';

List<ElectricainServiceProviderModel> likedProviders = getLikedServices();

class ElectricainServiceProviderModel {
  int id;
  String name;
  String providerImage;
  String occupation;
  String star;
  String detailDescription;
  String jobs;
  String perHourPrice;
  bool isLiked;
  List<ProviderServicesModel> providerServices;

  ElectricainServiceProviderModel(
      this.id,
      this.name,
      this.providerImage,
      this.occupation,
      this.star,
      this.detailDescription,
      this.jobs,
      this.perHourPrice,
      this.isLiked,
      this.providerServices);
}


List<ElectricainServiceProviderModel> getElectriciansforHome() {
  List<ElectricainServiceProviderModel> list = List.empty(growable: true);
  list.add(ElectricainServiceProviderModel(1, "Michel smith", electrician, "Electrician for fan",
      "3.5", "Hi", "120", "250", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Michel smith", painter1, "painter", "3.5",
      "Hi", "120", "150", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "John carter", homeCleaner, "Electricain for wiring",
      "4.5", "Hi", "120", "220", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Carry John", electrician, "Earthing", "4.0",
      "Hi", "120", "220", false, getProviderServices()));
  return list;
}

List<ElectricainServiceProviderModel> getElectriciansforBuilder() {
  List<ElectricainServiceProviderModel> list = List.empty(growable: true);
  list.add(ElectricainServiceProviderModel(1, "Michel John", electrician, "Electrician for fan",
      "3.5", "Hi", "120", "250", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "John fuquaj", electrician, "painter", "3.5",
      "Hi", "120", "150", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "John carter", homeCleaner, "Home Clean",
      "4.5", "Hi", "120", "220", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Carry smith", plumber, "Electricain for wiring", "4.0",
      "Hi", "120", "220", false, getProviderServices()));
  return list;
}

List<ElectricainServiceProviderModel> getElectriciansforIndustries() {
  List<ElectricainServiceProviderModel> list = List.empty(growable: true);
  list.add(ElectricainServiceProviderModel(1, "Michel smith", electrician, "Electrician for fan",
      "3.5", "Hi", "120", "250", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Michel smith", painter1, "Electricain for wiring", "3.5",
      "Hi", "120", "150", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "John carter", homeCleaner, "Earthing",
      "4.5", "Hi", "120", "220", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Carry John", electrician, "plumber", "4.0",
      "Hi", "120", "220", false, getProviderServices()));
  return list;
}
List<ElectricainServiceProviderModel> getElectriciansforOffice() {
  List<ElectricainServiceProviderModel> list = List.empty(growable: true);
  list.add(ElectricainServiceProviderModel(1, "Michel smith", electrician, "Electrician for fan",
      "3.5", "Hi", "120", "250", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Michel smith", painter1, "painter", "3.5",
      "Hi", "120", "150", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "John carter", electrician, "Electricain for wiring",
      "4.5", "Hi", "120", "220", false, getProviderServices()));
  list.add(ElectricainServiceProviderModel(1, "Carry John", plumber, "Earthing", "4.0",
      "Hi", "120", "220", false, getProviderServices()));
  return list;
}

List<ElectricainServiceProviderModel> getLikedServices() {
  List<ElectricainServiceProviderModel> list = List.empty(growable: true);
  list.add(ElectricainServiceProviderModel(
    0,
    "John Smith",
    homeCleaner,
    "Home Cleaning",
    "3.5",
    "Plumbers install and repair plumbing systems in residential and commercial properties. They also install fixtures and domestic appliances associated with heating, cooling, and sanitation systems.Plumbers install and repair plumbing systems in residential and commercial properties.",
    "1000",
    "150",
    true,
    getProviderServices(),
  ));
  list.add(ElectricainServiceProviderModel(
    1,
    "Marry John",
    painter,
    "Home Painting",
    "4.0",
    "Plumbers install and repair plumbing systems in residential and commercial properties. They also install fixtures and domestic appliances associated with heating, cooling, and sanitation systems.Plumbers install and repair plumbing systems in residential and commercial properties.",
    "90",
    "190",
    true,
    getProviderServices(),
  ));
  return list;
}

void addFavouriteProviderelec(int serviceIndex, int index) {
  likedProviders.add(ElectricainServiceProviderModel(
    serviceProviders[serviceIndex].serviceProviders[index].id,
    serviceProviders[serviceIndex].serviceProviders[index].name,
    serviceProviders[serviceIndex].serviceProviders[index].providerImage,
    serviceProviders[serviceIndex].serviceProviders[index].occupation,
    serviceProviders[serviceIndex].serviceProviders[index].star,
    serviceProviders[serviceIndex].serviceProviders[index].detailDescription,
    serviceProviders[serviceIndex].serviceProviders[index].jobs,
    serviceProviders[serviceIndex].serviceProviders[index].perHourPrice,
    true,
    serviceProviders[serviceIndex].serviceProviders[index].providerServices,
  ));
}

void removeFavouriteelecProviderelec(int serviceIndex, int index) {
  for (int i = 0; i < likedProviders.length; i++) {
    if (serviceProviders[serviceIndex].serviceProviders[index].name ==
        likedProviders[i].name) {
      likedProviders.removeAt(i);
    }
  }
}
