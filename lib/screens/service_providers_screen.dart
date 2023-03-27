import 'package:aelius_customer/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/electrican_services_model.dart';
import '../models/services_model.dart';
import '../utils/api_list.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class ServiceProvidersScreen extends StatefulWidget {
  final int index;
  final bool servicesss;

  const ServiceProvidersScreen(
      {Key? key, required this.index, required this.servicesss})
      : super(key: key);

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  List<Datum> category_list = [];

  Future<void> _fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);
    setState(() {
      category_list = data.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategorie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
            IconThemeData(color: appData.isDark ? whiteColor : blackColor),
        title: Text(
          "Service Providers",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: appData.isDark ? whiteColor : blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: category_list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // _navigateToProviderDetailScreen(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appData.isDark
                          ? Colors.black
                          : Colors.grey.withOpacity(0.2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: category_list[0].file,
                                fit: BoxFit.cover,
                                height: 150,
                                width: 100,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Center(
                                  child: Image.asset(
                                    userImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    widget.servicesss == false
                                        ? setLiked(widget.index, index)
                                        : setLikedelec(widget.index, index);
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 18,
                                    backgroundColor: likedIconBackColor,
                                    child: SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: serviceProviders[widget.index]
                                                .serviceProviders[index]
                                                .isLiked
                                            ? const Icon(
                                                Icons.favorite,
                                                size: 18,
                                                color: Colors.red,
                                              )
                                            : Image.asset(icHeart,
                                                color: Colors.black)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Space(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category_list[widget.index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const Space(4),
                                  Text(
                                    category_list[0].status.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: greyColor, fontSize: 14),
                                  ),
                                  const Space(4),
                                  Row(
                                    children: [
                                      const Text(
                                        "Started :- ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const Space(10),
                                      Text(
                                        "${category_list[0].createdAt.day}-${category_list[0].createdAt.month}-${category_list[0].createdAt.year}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Space(16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
