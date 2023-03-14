import 'package:flutter/material.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'last_booking_screen.dart';

class OrderSummeryScreen extends StatefulWidget {


  const OrderSummeryScreen({
    Key? key,
   
  }) : super(key: key);

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {
  int index = 0;
  int itemCount = 1;
  int price = 0;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Order Summery",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding:const EdgeInsets.all(10),
            child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: appData.isDark
                    ? bottomContainerDark
                    : bottomContainerBorder,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                 
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LastBookingScreen(
                            cancel: false,
                            weekday: "thusday",
                            date: "23/03/2023",
                            time: "07:30 pm",
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "confirmation ",
                      style: TextStyle(
                        color: appData.isDark
                            ? bottomContainerTextDark
                            : bottomContainerText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              color: appData.isDark ? cardColorDark : cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                   electrician,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const Space(16),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Home Electrician",
                                  textAlign: TextAlign.start,
                                  style:  TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                const Space(8),
                                Text(
                                  "John Fuquaj",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: appData.isDark
                                          ? cardTextDark
                                          : cardText,
                                      fontSize: 12),
                                ),
                                const Space(4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.watch_later_outlined,
                                        color: appData.isDark
                                            ? cardTextDark
                                            : cardText,
                                        size: 14),
                                    const Space(2),
                                    const Text("7:30 pm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)),
                                    const Space(2),
                                    Text("on",
                                        style: TextStyle(
                                            color: appData.isDark
                                                ? cardTextDark
                                                : cardText,
                                            fontSize: 8)),
                                    const Space(2),
                                    const Text(
                                     "Thursday",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: (BorderRadius.circular(5)),
                            border: Border.all(
                                width: 1, color: itemCountContainerBorder),
                            color: itemCountContainer,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (itemCount != 1) {
                                    itemCount--;
                                    setState(() {});
                                  }
                                },
                                child:const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(Icons.remove,
                                        color: blackColor, size: 16)),
                              ),
                              Container(
                                margin:const EdgeInsets.symmetric(horizontal: 3),
                                padding:const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: whiteColor),
                                child: Text(itemCount.toString(),
                                    style:const TextStyle(
                                        color: blackColor, fontSize: 16)),
                              ),
                              InkWell(
                                onTap: () {
                                  itemCount++;
                                  setState(() {});
                                },
                                child:const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(Icons.add,
                                        color: blackColor, size: 16)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Space(28),
                   
                  ],
                ),
              ),
            ),
            const Space(8),
            Card(
              color: appData.isDark ? cardColorDark : cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const Space(24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          const Space(4),
                          Text(
                            "2nd Street,Shushruthi Nagar,E City",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: appData.isDark ? cardTextDark : cardText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Space(8),
                    const Icon(Icons.edit, size: 20),
                  ],
                ),
              ),
            ),
            const Space(8),
         
          ],
        ),
      ),
    );
  }
}
