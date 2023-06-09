import 'package:flutter/material.dart';

import '../custom_widget/service_requestscreen_widget.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../models/active_bookings_model.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class CategoryBookingComponent extends StatelessWidget {
  final ActiveBookingsModel? activeBookingsModel;
  final int index;
  final String workprocess;

  const CategoryBookingComponent(this.index, {super.key, this.activeBookingsModel,required this.workprocess});

  @override
  Widget build(BuildContext context) {
    return condition(context,workprocess);
  }

  condition( BuildContext context, String workprocess){
    if(workprocess == "WorkDone"){
      return activeBookingsModel!.status == "Completed" ? GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ServicesRequestScreenWidget(indexint: index,isfavorite: false,isbest: false,),
        );
      },
      child:  Padding(
        padding:const EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeBookingsModel!.serviceName,
                      textAlign: TextAlign.start,
                      style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      activeBookingsModel!.status,
                      textAlign: TextAlign.start,
                      style:const TextStyle(
                        color:  blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Space(4),
                Divider(color: dividerColor, thickness: 1),
                const Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                    const Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activeBookingsModel!.name,
                            style:const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        const Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Icon( Icons.arrow_circle_right,
                                color: orangeColor,
                                size: 16),
                            const Space(2),
                            Text(activeBookingsModel!.date,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const Space(2),
                            const Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            const Space(2),
                            Text(activeBookingsModel!.time,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ):Container();
    }else if(workprocess == "WorkinProcess"){
      return activeBookingsModel!.status == "In Process" ?GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ServicesRequestScreenWidget(indexint: index,isfavorite: false,isbest: false,),
        );
      },
      child:  Padding(
        padding:const EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeBookingsModel!.serviceName,
                      textAlign: TextAlign.start,
                      style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      activeBookingsModel!.status,
                      textAlign: TextAlign.start,
                      style:const TextStyle(
                        color:  blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Space(4),
                Divider(color: dividerColor, thickness: 1),
                const Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                   const  Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activeBookingsModel!.name,
                            style:const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        const Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Icon( Icons.arrow_circle_right,
                                color: orangeColor,
                                size: 16),
                            const Space(2),
                            Text(activeBookingsModel!.date,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const Space(2),
                            const Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            const Space(2),
                            Text(activeBookingsModel!.time,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ):Container();
    }
    else if(workprocess == "WorkPermission"){
      return activeBookingsModel!.status == "Assigned"? GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ServicesRequestScreenWidget(indexint: index,isfavorite: false,isbest: false,),
        );
      },
      child:  Padding(
        padding:const EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeBookingsModel!.serviceName,
                      textAlign: TextAlign.start,
                      style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      activeBookingsModel!.status,
                      textAlign: TextAlign.start,
                      style:const TextStyle(
                        color:  blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Space(4),
                Divider(color: dividerColor, thickness: 1),
                const Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                   const  Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activeBookingsModel!.name,
                            style:const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        const Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Icon( Icons.arrow_circle_right,
                                color: orangeColor,
                                size: 16),
                            const Space(2),
                            Text(activeBookingsModel!.date,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const Space(2),
                            const Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            const Space(2),
                            Text(activeBookingsModel!.time,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ):Container();
    }
    else if(workprocess == "Workcancel"){
      return activeBookingsModel!.status=="Cancel"? GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ServicesRequestScreenWidget(indexint: index,isfavorite: false,isbest: false,),
        );
      },
      child:  Padding(
        padding:const EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeBookingsModel!.serviceName,
                      textAlign: TextAlign.start,
                      style:const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(
                      activeBookingsModel!.status,
                      textAlign: TextAlign.start,
                      style:const TextStyle(
                        color:  blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Space(4),
                Divider(color: dividerColor, thickness: 1),
                const Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        child: Image.asset(home, fit: BoxFit.cover),
                      ),
                    ),
                   const  Space(8),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activeBookingsModel!.name,
                            style:const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        const Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Icon( Icons.arrow_circle_right,
                                color: orangeColor,
                                size: 16),
                            const Space(2),
                            Text(activeBookingsModel!.date,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            const Space(2),
                            const Text("at",
                                style: TextStyle(
                                    color: orangeColor, fontSize: 12)),
                            const Space(2),
                            Text(activeBookingsModel!.time,
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ):Container();
    }
    
  }

 
}


