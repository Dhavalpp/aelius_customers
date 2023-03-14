import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../utils/colors.dart';

class AddMediaPage extends StatefulWidget {
  const AddMediaPage({super.key});

  @override
  State<AddMediaPage> createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  final TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
            IconThemeData(color: appData.isDark ? whiteColor : blackColor),
        title: Text(
          "Create New Post",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: appData.isDark ? whiteColor : blackColor),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'What do you want to talk about?',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Card(
                  elevation: 3,
                  child: IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      _selectPicture();
                    },
                  ),
                ),
                Card(
                  elevation: 3,
                  child: IconButton(
                    icon: const Icon(Icons.video_call),
                    onPressed: () {
                    },
                  ),
                ),
                Card(
                  elevation: 3,
                  child: IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add post functionality
        },
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _selectPicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
      } else {
        print('No image selected.');
      }
    });
  }
}
