import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/images.dart';
import '../custom_widget/space.dart';


class NotificationMemberProfile extends StatefulWidget {
  int completed;
   NotificationMemberProfile({Key? key,required this.completed}) : super(key: key);

  @override
  _NotificationMemberProfileState createState() => _NotificationMemberProfileState();
}

class _NotificationMemberProfileState extends State<NotificationMemberProfile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
       child: SizedBox(
         height: 350,

         child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

             children: [
             if(widget.completed.isEven)
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [const Space(8),
                   const SizedBox(height: 100,width: 100,child: CircleAvatar(backgroundImage: AssetImage(userImage),)),
                   const Space(15),

                   Row(
                       textDirection: TextDirection.ltr,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: const [
                         Text("Name:- ",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                         Text("Johnson",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,),),
                         Divider(height: 5.0,color: Colors.grey,),]
                   ),
                   Row(
                       textDirection: TextDirection.ltr,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: const [
                         Divider(height: 5.0,color: Colors.grey,),
                         Text("Mobile No.:-",textAlign: TextAlign.left,style: TextStyle( fontSize: 16,fontWeight: FontWeight.bold,)),
                         Text("+91 1234567890",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,),),
                         Divider(height: 5.0,color: Colors.grey,),

                       ]
                   ),
                   const Padding(
                     padding:  EdgeInsets.all(8.0),
                     child: Center(
                       child: Text(
                         'Share this OTP with this services person..',
                         style: TextStyle(
                           fontSize: 16,
                         ),
                       ),
                     ),
                   ),
                   const Space(5),
                   const Text(
                     'Your OTP is 1520',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   const Space(8),
                   ElevatedButton(
                     onPressed: () {
                       Navigator.pop(context);
                     },
                     child:const Text('Close'),
                   ),],
               ),
             if(widget.completed.isOdd)
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Center(
                       child: Text(textAlign: TextAlign.justify,
                         'Thank you For Getting Services from Home to House Kindly Share Your FeedBack to Use that help use better Services',
                         style: TextStyle(
                           fontSize: 17,
                         ),
                       ),
                     ),
                   ),
                   const Space(8),
                   const Divider(thickness: 5.0,color: Colors.grey,),
                   const Space(5),
                   const Text(textAlign: TextAlign.justify,
                     'Home 2 House',
                     style: TextStyle(
                       fontSize: 20,fontWeight: FontWeight.bold
                     ),
                   ),
                   const Space(8),
                   RatingBarWidget(onRatingChanged:(rating) {
                   },itemCount: 5,size: 45,),
                   const Space(8),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       ElevatedButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child:const Text('Submit'),
                       ),
                       ElevatedButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child:const Text('Close'),
                       ),
                     ],
                   ),
                 ],
               )


           ]
         ),
       )
    );
  }
}
