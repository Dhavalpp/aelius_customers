import 'package:aelius_customer/screens/provider_detail_screen.dart';
import 'package:flutter/material.dart';

import '../custom_widget/service_request_dialog_with_category.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../models/electrican_services_model.dart';
import '../models/services_model.dart';
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
  Future<void> _navigateToProviderDetailScreen(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProviderDetailScreen(serviceIndex: widget.index, index: index),
      ),
    );
    if (result) {
      setState(() {});
    }
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
          widget.servicesss == true
              ? "Electrician Services Provider"
              : "Service Providers",
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
            Column(children: [
              const Text(
                "Don't Know about Any Service Men ?",
                style: TextStyle(fontSize: 15),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ServicesRequestDialogWithCategory(nearestser: true,
                     
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape:const StadiumBorder(),
                    backgroundColor: appData.isDark
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.black,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 8, bottom: 8)),
                child:const Text("Find Nearest",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ),
            ]),
            ListView.builder(
              padding:const  EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: widget.servicesss == false
                  ? serviceProviders[widget.index].serviceProviders.length
                  : electricainserviceProviders[widget.index]
                      .electricainserviceProviders
                      .length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToProviderDetailScreen(index);
                  },
                  child: Container(
                    padding:const  EdgeInsets.all(16),
                    margin:const  EdgeInsets.only(bottom: 16),
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
                              child: Image.asset(
                                widget.servicesss == false
                                    ? serviceProviders[widget.index]
                                        .serviceProviders[index]
                                        .providerImage
                                    : electricainserviceProviders[widget.index]
                                        .electricainserviceProviders[index]
                                        .providerImage,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Padding(
                                padding:const  EdgeInsets.all(6.0),
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
                                      child: electricainserviceProviders[
                                                  widget.index]
                                              .electricainserviceProviders[
                                                  index]
                                              .isLiked
                                          ? serviceProviders[widget.index]
                                                  .serviceProviders[index]
                                                  .isLiked
                                              ? const Icon(
                                                  Icons.favorite,
                                                  size: 18,
                                                  color: Colors.red,
                                                )
                                              : Image.asset(icHeart,
                                                  color: Colors.black)
                                          :const  Icon(
                                              Icons.favorite,
                                              size: 18,
                                              color: Colors.red,
                                            ),
                                    ),
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
                                    widget.servicesss == false
                                        ? serviceProviders[widget.index]
                                            .serviceProviders[index]
                                            .name
                                        : electricainserviceProviders[
                                                widget.index]
                                            .electricainserviceProviders[index]
                                            .name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style:const  TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const Space(4),
                                  Text(
                                    widget.servicesss == false
                                        ? serviceProviders[widget.index]
                                            .serviceProviders[index]
                                            .occupation
                                        : electricainserviceProviders[
                                                widget.index]
                                            .electricainserviceProviders[index]
                                            .occupation,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style:const  TextStyle(
                                        color: greyColor, fontSize: 14),
                                  ),
                                  const Space(4),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: starIconColor, size: 16),
                                      Text(
                                        widget.servicesss == false
                                            ? serviceProviders[widget.index]
                                                .serviceProviders[index]
                                                .star
                                            : electricainserviceProviders[
                                                    widget.index]
                                                .electricainserviceProviders[
                                                    index]
                                                .star,
                                        style:const  TextStyle(
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
