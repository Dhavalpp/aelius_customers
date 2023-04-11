import 'package:aelius_customer/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/space.dart';
import '../main.dart';
import '../models/services_list_model.dart';
import '../utils/api_list.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class ServiceProvidersScreen extends StatefulWidget {
  final String categoryName;
  final bool servicesss;

  const ServiceProvidersScreen(
      {Key? key, required this.categoryName, required this.servicesss})
      : super(key: key);

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  List<CategoryDatum> category_list = [];

  List<ServicesDatum> services_list = [];
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  Future<void> _fetchCategorie() async {
    final response = await http.get(Uri.parse(categoryUrl));
    final data = categoryFromJson(response.body);

    setState(() {
      category_list = data.data;
    });
  }

  Future<int?> fetchCategoryIdByName(String categoryName) async {
    final response = await http.get(
      Uri.parse(categoryUrl),
    );

    if (response.statusCode == 200) {
      final category = categoryFromJson(response.body);
      final categoryDatum = category.data.firstWhere(
        (element) => element.name.toLowerCase() == categoryName.toLowerCase(),
      );

      return categoryDatum.id;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> callSpecificMemberAPI() async {
    final categoryId = await fetchCategoryIdByName(widget.categoryName);
    if (categoryId != null) {
      // do something with categoryId
      print(categoryId);
    } else {
      // handle the case where no category was found with the given name
    }

    var url = Uri.parse(servicesListUrl);
    var response = await http.post(url, body: {
      'category_id': categoryId.toString(),
    });

    if (response.statusCode == 200) {
      final data = servicesListModelFromJson(response.body);

      setState(() {
        services_list = data.data;
      });
    } else {
      // Handle the error here
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callSpecificMemberAPI();
    _fetchCategorie();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
            SizedBox(
              height: screenHeight,
              child: category_list.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      itemCount: services_list.length,
                      itemBuilder: (context, index) {
                        return services_list.isEmpty
                            ? const Center(
                                child: Text(
                                "No data Found",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ))
                            : GestureDetector(
                                onTap: () {
                                  // _navigateToProviderDetailScreen(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: appData.isDark
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: imagecategoryURl +
                                                  services_list[0].image!,
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 100,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Image.asset(
                                                  userImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //   bottom: 0,
                                          //   left: 0,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(6.0),
                                          //     child: GestureDetector(
                                          //       onTap: () {
                                          //         widget.servicesss == false
                                          //             ? setLiked(widget.index, index)
                                          //             : setLikedelec(widget.index, index);
                                          //         setState(() {});
                                          //       },
                                          //       child: CircleAvatar(
                                          //         maxRadius: 18,
                                          //         backgroundColor: likedIconBackColor,
                                          //         child: SizedBox(
                                          //             height: 16,
                                          //             width: 16,
                                          //             child: serviceProviders[widget.index]
                                          //                     .serviceProviders[index]
                                          //                     .isLiked
                                          //                 ? const Icon(
                                          //                     Icons.favorite,
                                          //                     size: 18,
                                          //                     color: Colors.red,
                                          //                   )
                                          //                 : Image.asset(icHeart,
                                          //                     color: Colors.black)),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      const Space(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  services_list[index].fullName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 20),
                                                ),
                                                const Space(4),
                                                Text(
                                                  category_list[index]
                                                      .status
                                                      .name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: greyColor,
                                                      fontSize: 12),
                                                ),
                                                const Space(4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Started :- ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    const Space(10),
                                                    Text(
                                                      "${category_list[0].createdAt.day}-${category_list[0].createdAt.month}-${category_list[0].createdAt.year}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Space(16),
                                            Text(
                                              services_list[index]
                                                  .categoriesName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20),
                                            ),
                                            const Space(16),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Company Name :- ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  services_list[index]
                                                      .companyName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            // SizedBox(
            //   height:screenHeight/2 ,
            //   child:  FutureBuilder<ServicesDatum>(
            //     future: servicesList(widget.index.toString()),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         final services = snapshot.data!;
            //         return
            //           ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemCount: 10,
            //           itemBuilder: (context, index) {
            //             return Card(
            //                 color: appData.isDark ? cardColorDark : cardColor,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(8)),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Row(
            //                     children: [
            //                       // const Icon(Icons.add_reaction_sharp, size: 20),
            //                       const Space(16),
            //                       Column(
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.start,
            //                         children: [
            //                           Text(services.fullName,
            //                               style: const TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           const Space(8),
            //                           Text(
            //                             services.companyName,
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.normal,
            //                               color: appData.isDark
            //                                   ? Colors.white70
            //                                   : Colors.grey.withOpacity(0.6),
            //                             ),
            //                           ),
            //                           const Space(8),
            //                           Text(
            //                             services.status,
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.normal,
            //                               color: appData.isDark
            //                                   ? Colors.white70
            //                                   : Colors.grey.withOpacity(0.6),
            //                             ),
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ));
            //           },
            //         );
            //       } else if (snapshot.hasError) {
            //         return Center(
            //           child: Text('${snapshot.error}'),
            //         );
            //       } else {
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
