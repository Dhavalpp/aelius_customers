import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/services_model.dart';
import '../screens/service_providers_screen.dart';
import '../utils/colors.dart';
class RoomServiceComponent extends StatefulWidget {
  const RoomServiceComponent({super.key});

  @override
  State<RoomServiceComponent> createState() => _RoomServiceComponentState();
}

class _RoomServiceComponentState extends State<RoomServiceComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: serviceProviders.length,
        scrollDirection: Axis.vertical,
        padding:const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceProvidersScreen(index: index,servicesss: true)),
            );
            for (var i = 0; i < serviceProviders.length; i++) {
              if (i == index) {
                serviceProviders[i].isSelected = true;
              } else {
                serviceProviders[i].isSelected = false;
              }
              setState(() {});
            }
          },
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Container(
                    padding:const EdgeInsets.all(16),
                    color: serviceProviders[index].isSelected
                        ? blackColor
                        : textFieldColor,
                    child: Observer(
                      builder: (context) {
                        return Icon(
                          serviceProviders[index].serviceIcon,
                          size: 28,
                          color: appData.isDark
                              ? Colors.white
                              : serviceProviders[index].isSelected
                                  ? whiteColor
                                  : blackColor,
                        );
                      },
                    ),
                  ),
                ),
                const Space(8),
                FittedBox(child: Text(serviceProviders[index].serviceName)),
              ],
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }
}
