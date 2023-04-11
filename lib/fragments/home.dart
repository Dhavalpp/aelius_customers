import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/home_contruction_component.dart';
import '../custom_widget/new_services_request_dialog.dart';
import '../custom_widget/service_request_dialog_with_category.dart';
import '../custom_widget/space.dart';
import '../main.dart';
import '../models/banner_list_model.dart';
import '../models/user_model.dart';
import '../screens/reward_point_screen.dart';
import '../utils/api_list.dart';
import '../utils/images.dart';
import '../utils/shared_pref.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  int bannerSize = 2;

  final offerPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController =
      PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  late UserModel? userModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePreferenceData();
    bannerSize;
  }

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  Future<dynamic> sharePreferenceData() async {
    UserModel? userData = await SharedPref().getSharedPreferences();
    setState(() {
      userModels = userData;
      print(userModels!.detail[0].fullName);
    });
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
            SizedBox(
              height: 170,
              child: FutureBuilder<BannerListModel>(
                future: fetchBannerList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final banners = snapshot.data!.data;
                    bannerSize = banners.length;

                    return PageView.builder(
                      controller: offerPagesController,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final banner = banners[index];
                        return Center(
                          child: CachedNetworkImage(
                            imageUrl: imagebannerURl + banner.image,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset(banner1),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            SmoothPageIndicator(
              controller: offerPagesController,
              count: bannerSize,
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
                  iconSizebox(icprofile, "Immediate Services", 0),
                  iconSizebox(icservices, "Schedule Services", 1),
                  iconSizebox(icreward, "Reward Point", 2)
                ],
              ),
            ),
            const Space(18),
            // homeTitleWidget(
            //   titleText: "Electrical Services",
            // ),
            // const Space(10),
            // const RoomServiceComponent(),
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

  void _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            "CustomerImmediate", "Your Services is Requested",
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        014,
        'Your Services is Requested',
        'Requested services of $categoryUrl',
        platformChannelSpecifics,
        payload: 'item x');
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
                    width: screenWidth / 4,
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
                ? showDialog(
                    context: context,
                    builder: (context) => const NewServicesRequestDialog(),
                  )
                : sizeid == 1
                    ? showDialog(
                        context: context,
                        builder: (context) => ServicesRequestDialogWithCategory(
                          nearestser: false,
                        ),
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
