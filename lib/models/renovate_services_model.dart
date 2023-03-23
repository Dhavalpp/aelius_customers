import '../utils/images.dart';
import 'common_model.dart';

List<CommonModel> renovateServices = getRenovateServices();

List<CommonModel> getRenovateServices() {
  List<CommonModel> renovateServices = [];
  renovateServices
      .add(CommonModel.withoutIcon("Home Interiors", room, isSelected: true));
  renovateServices.add(
      CommonModel.withoutIcon("Modular Kitchen", kitchen, isSelected: false));
  renovateServices.add(CommonModel.withoutIcon("Commercial Buildings", building,
      isSelected: false));
  renovateServices.add(
      CommonModel.withoutIcon("Office Interior", office, isSelected: false));
  return renovateServices;
}
