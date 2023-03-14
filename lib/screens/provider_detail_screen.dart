import 'package:flutter/material.dart';
import '../components/service_list_component.dart';
import '../custom_widget/space.dart';
import '../models/renovate_services_model.dart';
import '../models/services_model.dart';
import '../utils/colors.dart';
import '../utils/widget.dart';

class ProviderDetailScreen extends StatefulWidget {
  final int serviceIndex;
  final int index;

  const ProviderDetailScreen(
      {Key? key, required this.serviceIndex, required this.index})
      : super(key: key);

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: transparent,
          title: const Text(
            "Details",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  serviceProviders[widget.serviceIndex]
                      .serviceProviders[widget.index]
                      .name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  serviceProviders[widget.serviceIndex]
                      .serviceProviders[widget.index]
                      .detailDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: subTitle, fontSize: 14),
                ),
              ),
              const Space(8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              blackColor,
                              transparent,
                              transparent,
                              transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.2, 0.8, 1],
                          ),
                        ),
                        child: Image.asset(
                          serviceProviders[widget.serviceIndex]
                              .serviceProviders[widget.index]
                              .providerImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text("jobs",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 12)),
                                const Space(4),
                                Text(
                                  serviceProviders[widget.serviceIndex]
                                      .serviceProviders[widget.index]
                                      .jobs,
                                  style: const TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text("share",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 12)),
                                Space(4),
                                Icon(
                                  Icons.share,
                                  color: whiteColor,
                                  size: 18,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Rating",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 12)),
                                const Space(4),
                                Text(
                                  serviceProviders[widget.serviceIndex]
                                      .serviceProviders[widget.index]
                                      .star,
                                  style: const TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Save",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 12)),
                                const Space(4),
                                GestureDetector(
                                  onTap: () {
                                    setLiked(widget.serviceIndex, widget.index);
                                    setState(() {});
                                  },
                                  child: serviceProviders[widget.serviceIndex]
                                          .serviceProviders[widget.index]
                                          .isLiked
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red, size: 18)
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Space(32),
              homeTitleWidget(
                titleText: "Recent Projects",
              ),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: List.generate(
                    renovateServices.length,
                    (index) => ServiceListComponent(
                        commonModel: renovateServices[index], index: index),
                  ),
                ),
              ),
              const Space(70),
            ],
          ),
        ),
      ),
    );
  }
}
