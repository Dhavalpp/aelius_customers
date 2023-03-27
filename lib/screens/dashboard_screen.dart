import 'package:aelius_customer/models/user_model.dart';
import 'package:aelius_customer/screens/reward_point_screen.dart';
import 'package:aelius_customer/screens/sign_in_screen.dart';
import 'package:aelius_customer/utils/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../custom_widget/space.dart';
import '../fragments/bookings_fragment.dart';
import '../fragments/home.dart';
import '../fragments/search_fragment.dart';
import '../main.dart';
import '../models/customer_details_model.dart';
import '../utils/colors.dart';
import '../utils/shared_pref.dart';
import '../utils/widget.dart';
import 'favourite_services_screen.dart';
import 'my_profile_screen.dart';
import 'notification_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? _currentBackPressTime;

  late UserModel? userModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem;
    sharePreferenceData();
  }

  final _pageItem = [
    const Home(),
    const SearchFragment(),
    const BookingsFragment(fromProfile: false),
    // AccountFragment(),
  ];

  final _titleItem = [
    "Dashbord",
    "My List",
    "H2H Media",
  ];
  int _selectedItem = 0;

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
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
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_titleItem[_selectedItem],
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            elevation: 0,
            backgroundColor: transparent,
            iconTheme: const IconThemeData(size: 30),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, size: 22),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 40, bottom: 24),
                  color: appData.isDark ? Colors.black : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: CachedNetworkImage(
                          imageUrl: userModels!.detail[0].image,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Center(
                            child: Image.asset(
                              userImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Space(4),
                      Text(
                        userModels!.detail[0].fullName,
                        style: TextStyle(
                            fontSize: 18,
                            color: appData.isDark ? whiteColor : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Space(4),
                      Text(
                        userModels!.detail[0].whatsappNumber.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: appData.isDark ? whiteColor : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Space(4),
                      Text(userModels!.detail[0].emailId,
                          style: const TextStyle(color: secondaryColor)),
                    ],
                  ),
                ),
                drawerWidget(
                  drawerTitle: "Home",
                  drawerIcon: Icons.home,
                  drawerOnTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedItem = 1;
                    });
                    _selectedItem = 0;
                  },
                ),
                drawerWidget(
                  drawerTitle: "List",
                  drawerIcon: Icons.list,
                  drawerOnTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedItem = 1;
                    });
                  },
                ),
                drawerWidget(
                  drawerTitle: "H2H Media Page",
                  drawerIcon: Icons.post_add_sharp,
                  drawerOnTap: () {
                    setState(() {
                      _selectedItem = 2;
                    });
                    Navigator.pop(context);
                  },
                ),
                drawerWidget(
                  drawerTitle: "My Favourites",
                  drawerIcon: Icons.favorite,
                  drawerOnTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const FavouriteProvidersScreen()));
                  },
                ),
                drawerWidget(
                  drawerTitle: "My Rewarded Point",
                  drawerIcon: Icons.point_of_sale,
                  drawerOnTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RewardPointScreen()));
                  },
                ),
                drawerWidget(
                  drawerTitle: "Notifications",
                  drawerIcon: Icons.notifications,
                  drawerOnTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  },
                ),
                drawerWidget(
                  drawerTitle: "Contact Us",
                  drawerIcon: Icons.mail,
                  drawerOnTap: () {
                    Navigator.pop(context);
                  },
                ),
                drawerWidget(
                  drawerTitle: "Help Center",
                  drawerIcon: Icons.question_mark_rounded,
                  drawerOnTap: () {
                    Navigator.pop(context);
                  },
                ),
                drawerWidget(
                  drawerTitle: "My Profile",
                  drawerIcon: Icons.person,
                  drawerOnTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProfileScreen()));
                  },
                ),
                drawerWidget(
                  drawerTitle: "Logout",
                  drawerIcon: Icons.logout,
                  drawerOnTap: () {
                    SharedPref.setLoggedIn(false);
                    Navigator.pop(context);
                    _showLogOutDialog();
                  },
                ),
              ],
            ),
          ),
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(size: 30, opacity: 1),
            unselectedIconTheme: const IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle: const TextStyle(fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            elevation: 40,
            selectedFontSize: 16,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 20),
                activeIcon: Icon(Icons.home_rounded, size: 20),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 20),
                activeIcon: Icon(Icons.list_alt_rounded, size: 20),
                label: "List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined, size: 20),
                activeIcon: Icon(Icons.video_library, size: 20),
                label: "H2h Meida",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
