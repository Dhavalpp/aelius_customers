import 'package:flutter/material.dart';

import '../custom_widget/social_media_card.dart';
import '../screens/add_media_screen.dart';
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

// List postIMages=[ { painter,sofa, bathroom,}];

List postname=[ { "Rakesh Varme","Ramesh Pipariya","Uday Singh"},];
List titlename=[ { "2d","3d","4d"},];
List headlinename=[ { "","Ramesh Pipariya","Uday Singh"},];
List contentname=[ { "Lorem Ipsum is simply dummy text","Lorem Ipsum is simply dummy text 12548","Lorem Ipsum is simply dummy text 125"},];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue.shade500,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>    const AddMediaPage()      );
        },
        icon:const  Icon(Icons.add,color: Colors.white,),
        label: const Text("POST",style: TextStyle(color: Colors.white),),
      ),


      // floatingActionButton: FloatingActionButton(onPressed: () {
      //    Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) =>AddMediaPage()),
      //       );
        
      // },
      // child: Center(child: Icon(Icons.add,color: Colors.white),)),
        body: ListView.builder(
         
          itemCount: 3,
 itemBuilder:(context, index) {
   return Column(
     children:const  [
       SocialMediaCard(
                  postImages: [
                    kitchen, office, building, contractor, electrician,
              
              ],
                  profileImageUrl: userImage,
                  headline: "Information Technology",
                  name: "Rakesh Varme",
                  postTime: "2d",
                  postContent:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                   
     ],
   );
 },
 ),);
  }
}
