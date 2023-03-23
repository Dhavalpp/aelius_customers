import 'package:flutter/material.dart';

import '../custom_widget/space.dart';
import '../models/home_construction_model.dart';
import '../screens/service_providers_screen.dart';
import '../utils/colors.dart';

class HomeConstructionComponent extends StatefulWidget {
  bool iconlist;

  HomeConstructionComponent({super.key, required this.iconlist});

  @override
  HomeConstructionComponentState createState() =>
      HomeConstructionComponentState();
}

class HomeConstructionComponentState extends State<HomeConstructionComponent> {
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
      height: 380,
      child:
          //
          widget.iconlist == false
              ? ListView.builder(
                  itemCount: homeConstruction.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceProvidersScreen(
                                    index: index,
                                    servicesss: false,
                                  )),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: textFieldColor,
                                child: homeConstruction[index].iconPath,
                              ),
                            ),
                            const SizedBox(width: 10),
                            FittedBox(
                                child: Text(homeConstruction[index].title)),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: home2houseConstruction.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServiceProvidersScreen(
                                  index:3 ,
                                  servicesss: false,
                                )),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Space(5),

                          SizedBox(
                            height: 70,
                            width: 70,
                            child: home2houseConstruction[index].iconPath,
                          ),
                          FittedBox(
                              child: Text(home2houseConstruction[index].title,style: const TextStyle(fontWeight: FontWeight.bold),)),
                          const Space(5),
                        ],
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                ),
    );
  }
}
