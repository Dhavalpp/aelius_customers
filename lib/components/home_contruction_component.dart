import 'package:aelius_customer/utils/api_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/space.dart';
import '../models/category.dart';
import '../models/user_model.dart';
import '../screens/service_providers_screen.dart';
import '../utils/images.dart';
import '../utils/shared_pref.dart';

class HomeConstructionComponent extends StatefulWidget {
  bool iconlist;

  HomeConstructionComponent({super.key, required this.iconlist});

  @override
  HomeConstructionComponentState createState() =>
      HomeConstructionComponentState();
}

class HomeConstructionComponentState extends State<HomeConstructionComponent> {
  List<CategoryDatum> category_list = [];

  @override
  void initState() {
    super.initState();
    _fetchCategorie();
    sharePreferenceData();
  }

  late UserModel? userModels;

  Future<dynamic> sharePreferenceData() async {
    UserModel? userData = await SharedPref().getSharedPreferences();
    setState(() {
      userModels = userData;
      print(userModels!.detail[0].fullName);
    });
  }

  Future<void> _fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);
    setState(() {
      category_list = data.data;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child:
          //
          widget.iconlist == false
              ? ListView.builder(
                  itemCount: category_list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ServiceProvidersScreen(
                                        index: category_list[index].id,
                                        servicesss: false,
                                      )),
                            );
                            print(category_list[index].id);
                          },
                          child: Card(
                            elevation: 8,
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: category_list[index].file,
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Center(
                                    child:
                                        Image.asset(banner1, fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FittedBox(
                                    child: Text(
                                  category_list[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: category_list.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, indexs) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceProvidersScreen(
                                  index: indexs,
                                  servicesss: false,
                                )),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Space(5),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CachedNetworkImage(
                              imageUrl: category_list[indexs].name,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset(banner1),
                              ),
                            ),
                          ),
                          FittedBox(
                              child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              category_list[indexs].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )),
                          // const Space(5),
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
