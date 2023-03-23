import 'package:aelius_customer/custom_widget/space.dart';
import 'package:flutter/material.dart';

class RewardPoint extends StatelessWidget {
  const RewardPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Your Reward Points",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.blue.shade100,
              elevation:5,
              shadowColor: Colors.green.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 25,
                      ),
                      Text(
                        "100",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Space(10),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
