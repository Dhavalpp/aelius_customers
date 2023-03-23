import 'package:flutter/material.dart';

import '../utils/images.dart';


class SocialMediaCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String headline;
  final String postTime;
  final String postContent;

  const SocialMediaCard({super.key,
    required this.profileImageUrl,
    required this.name,
    required this.headline,
    required this.postTime,
    required this.postContent,
    required this.postImages,
  });

  final List<String> postImages;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage:
                  AssetImage(userImage),
                  // NetworkImage(profileImageUrl),
                  radius: 20.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(headline),
                      const SizedBox(height: 4.0),
                      Text(
                        postTime,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postContent,
            ),
          ),
          // Image.asset("assets/images/plumber.jpg"),
          postImages.isNotEmpty
              ? LinkedInPostImages(imageUrls: postImages)
              : const SizedBox.shrink(),
          const SizedBox(height: 8.0),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.thumb_up_alt_outlined),
                      SizedBox(width: 4.0),
                      Text('Like'),
                    ],
                  ),
                  onTap: () {},
                ),
                GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.comment_outlined),
                      SizedBox(width: 4.0),
                      Text('Comment'),
                    ],
                  ),
                  onTap: () {
                    const Icon(Icons.comment_outlined);
                  },
                ),
                GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.share_outlined),
                      SizedBox(width: 4.0),
                      Text('Share'),
                    ],
                  ),
                  onTap: () {},
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LinkedInPostImages extends StatelessWidget {
  final List<String> imageUrls;

  const LinkedInPostImages({super.key, required this.imageUrls});


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      children: List.generate(imageUrls.length, (index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            image: DecorationImage(

              image: index == 0 || index == 2 || index == 4 ?const AssetImage(
                  userImage) :const AssetImage(electrician),


              // AssetImage(imageUrls[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
