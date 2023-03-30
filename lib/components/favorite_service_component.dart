import 'package:flutter/material.dart';

import '../custom_widget/service_requestscreen_widget.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../models/service_provider_model.dart';
import '../models/services_model.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class FavoriteServiceComponent extends StatefulWidget {
  final ServiceProviderModel? serviceProviderModel;


  final int index;

  const FavoriteServiceComponent(this.index, {super.key, this.serviceProviderModel});

  @override
  State<FavoriteServiceComponent> createState() =>
      _FavoriteServiceComponentState();
}

class _FavoriteServiceComponentState extends State<FavoriteServiceComponent> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin:const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appData.isDark ? Colors.black : Colors.grey.withOpacity(0.2),
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
                    widget.serviceProviderModel!.providerImage,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding:const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () {
                        setLiked(widget.index, widget.index);
                        setState(() {});
                      },
                      child: CircleAvatar(
                        maxRadius: 12,
                        backgroundColor: likedIconBackColor,
                        child: SizedBox(
                          height: 14,
                          width: 14,
                          child: widget.serviceProviderModel!.isLiked
                              ? const Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: redColor,
                                )
                              : Image.asset(icHeart, color: Colors.black),
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
                        widget.serviceProviderModel!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style:const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      const Space(4),
                      Text(
                        widget.serviceProviderModel!.occupation,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style:const TextStyle(color: greyColor, fontSize: 14),
                      ),
                      const Space(4),
                      Row(
                        children: [
                          Icon(Icons.star, color: starIconColor, size: 16),
                          Text(
                            widget.serviceProviderModel!.star,
                            style:const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Space(16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("",
                              style: TextStyle(
                                  color: blueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹${widget.serviceProviderModel!.perHourPrice}",
                                    style:const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const Text(
                                    "/hr ",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const Space(8),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ServicesRequestScreenWidget(
                                            indexint: widget.index,isfavorite: true,isbest: false,),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape:const StadiumBorder(),
                                  backgroundColor: appData.isDark
                                      ? Colors.grey.withOpacity(0.2)
                                      : Colors.black,
                                  padding:const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 32),
                                  fixedSize:const Size(140, 45),
                                ),
                                child:const Text("Book"),
                              ),
                            ],
                          ),
                        ],
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
  }
}
