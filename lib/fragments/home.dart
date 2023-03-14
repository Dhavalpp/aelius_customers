import 'package:flutter/material.dart';
import '../components/home_contruction_component.dart';
import '../components/room_service_component.dart';
import '../custom_widget/new_services_request_dialog.dart';
import '../custom_widget/space.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart';
import '../screens/my_profile_screen.dart';
import '../screens/reward_point_screen.dart';
import '../utils/images.dart';
import '../utils/widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  List<String> bannerList = [banner1, banner2, banner];

  final offerPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 17),
                  decoration: commonInputDecoration(
                    suffixIcon: Icon(Icons.search,
                        size: 20,
                        color: appData.isDark ? Colors.white : Colors.black),
                    hintText: "Search for services",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 170,
              child: PageView.builder(
                controller: offerPagesController,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image.asset(bannerList[index], fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: offerPagesController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 8,
                activeDotColor: appData.isDark ? Colors.white : Colors.black,
                expansionFactor: 2.2,
              ),
            ),
            const Space(18),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconSizebox(icprofile, "My Profile", 0),
                  iconSizebox(icservices, "Services Request", 1),
                  iconSizebox(icreward, "Reward Point", 2)
                ],
              ),
            ),
            const Space(18),
            homeTitleWidget(
              titleText: "Electrical Services",
            ),
            const Space(10),
            const RoomServiceComponent(),
            const Space(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomeConstructionComponent(
                iconlist: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox iconSizebox(String sizeicons, String sizeText, int sizeid) {
    return SizedBox(
      height: screenHeight / 4.8,
      width: screenWidth / 3,
      child: GestureDetector(
          child: Card(
            margin: const EdgeInsets.all(5.0),
            elevation: 3,
            child: Column(
              children: [
                SizedBox(
                    height: screenHeight / 8,
                    width: screenWidth / 5,
                    child: Image.asset(
                      sizeicons,
                    )),
                const Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  sizeText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            sizeid == 0
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfileScreen()),
                  )
                : sizeid == 1
                    ? showDialog(
                        context: context,
                        builder: (context) => const NewServicesRequestDialog(),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RewardPointScreen()),
                      );
          }),
    );
  }
}
