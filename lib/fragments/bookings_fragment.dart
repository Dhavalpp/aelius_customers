import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/social_media_card.dart';
import '../models/media_post_list.dart';
import '../utils/api_list.dart';
import '../utils/images.dart';

class BookingsFragment extends StatefulWidget {
  final bool fromProfile;

  const BookingsFragment({Key? key, required this.fromProfile})
      : super(key: key);

  @override
  State<BookingsFragment> createState() => _BookingsFragmentState();
}

class _BookingsFragmentState extends State<BookingsFragment>
    with SingleTickerProviderStateMixin {
  List<Datum> _listPost = [];

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    var url = Uri.parse(mediaListUrl);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      final data = mediaPostListFromJson(response.body);
      if (kDebugMode) {
        print(data.data);
      }
      setState(() {
        _listPost = data.data;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: ListView.builder(
          itemCount: _listPost.length,
          itemBuilder: (context, index) {
            // if (_listPost.isNotEmpty) {
            //   print(_listPost[index].id);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SocialMediaCard(
                postImages: [_listPost[index].image.toString()],
                profileImageUrl: userImage,
                name: _listPost[index].id.toString(),
                postTime: _listPost[index].createdAt.toString(),
                postContent: _listPost[index].desription,
              ),
            );
            // return Text(posts[index].desription);
            // } else {
            //   return Container();
            // }
          },
        ),
      ),

      // FutureBuilder<MediaPostList>(
      //   future: h2hMediaPostList(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       final posts = snapshot.data!.data;
      //
      //     } else if (snapshot.hasError) {
      //       print(snapshot.error);
      //       return const Center(
      //         child: Text('Failed to fetch posts'),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      // ListView.builder(
      //   itemCount: 3,
      //   itemBuilder: (context, index) {
      //     return Column(
      //       children: [
      //         SocialMediaCard(
      //             postImages: const [
      //               kitchen,
      //               office,
      //               building,
      //               contractor,
      //               electrician,
      //             ],
      //             profileImageUrl: userImage,
      //             // headline: "Information Technology",
      //             name: "Rakesh Varme",
      //             postTime: "2d",
      //             postContent:
      //                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

// class _BookingsFr/objectagmentState
