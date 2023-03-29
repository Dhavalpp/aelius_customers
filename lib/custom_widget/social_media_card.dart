import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/images.dart';

class SocialMediaCard extends StatefulWidget {
  String profileImageUrl;
  String name;
  final List<String> postImages;

  // String headline;
  String postTime;
  String? postContent;

  SocialMediaCard({
    super.key,
    required this.profileImageUrl,
    required this.name,
    // required this.headline,
    required this.postTime,
    required this.postContent,
    required this.postImages,
  });

  @override
  State<SocialMediaCard> createState() => _SocialMediaCardState();
}

class _SocialMediaCardState extends State<SocialMediaCard>
    with SingleTickerProviderStateMixin {
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
                  backgroundImage: AssetImage(userImage),
                  // NetworkImage(profileImageUrl),
                  radius: 20.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(headline),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.postTime,
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
              widget.postContent!,
            ),
          ),
          // Image.asset("assets/images/plumber.jpg"),
          widget.postImages.isNotEmpty
              ? LinkedInPostImages(imageUrls: widget.postImages)
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
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(imageUrls.length, (index) {
        return CachedNetworkImage(
          imageUrl: imageUrls[index],
          fit: BoxFit.cover,
          height: 150,
          width: 100,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(
            child: Image.asset(
              userImage,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
