import 'package:flutter/material.dart';
import '../components/payment_container.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import 'last_booking_screen.dart';

class PaymentScreen extends StatefulWidget {
    // final List<ActiveBookingsModel> list;
 
  const PaymentScreen({Key? key,  })
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();

 
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Payment",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding:const  EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Text(
                    "Rs.1505",
                    style: TextStyle(
                      color: appData.isDark
                          ? bottomContainerTextDark
                          : bottomContainerText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // activeBooking.add(widget.list[0]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const LastBookingScreen(
                            cancel: false,
                            weekday: "thusday",
                            date: "23/03/2023",
                            time: "07:30 pm",
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Pay",
                      style: TextStyle(
                        color: appData.isDark
                            ? bottomContainerTextDark
                            : bottomContainerText,
                        fontWeight: FontWeight.bold,
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
        padding:const EdgeInsets.all(20),
        child: Column(
          children: const [
            PaymentContainer(
                title: "Credit & Debit Cards", icon: Icons.credit_card),
            Space(16),
            PaymentContainer(title: "Net Banking", icon: Icons.food_bank),
            Space(16),
            PaymentContainer(
                title: "Cash On Delivery", icon: Icons.delivery_dining),
            Space(16),
            PaymentContainer(title: "Wallets", icon: Icons.wallet),
            Space(16),
            PaymentContainer(
                title: "UPIs", icon: Icons.book_online_rounded, isUpi: true),
            Space(55),
          ],
        ),
      ),
    );
  }
}
