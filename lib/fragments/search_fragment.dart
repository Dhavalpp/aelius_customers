import 'package:flutter/material.dart';
import '../components/home_contruction_component.dart';
import '../utils/colors.dart';
import '../utils/widget.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.blue.shade500,
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) =>
      //           ScheduleServiceRequestDialog(category: "Plumber"),
      //     );
      //   },
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   label: Text(
      //     "Services",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style:const TextStyle(fontSize: 17),
                  decoration: commonInputDecoration(
                    hintText: "Search for services",
                    suffixIcon:const Icon(Icons.search, size: 18),
                  ),
                ),
              ),
            ),
             Padding(
              padding:const  EdgeInsets.all(8.0),
              child:
              HomeConstructionComponent(iconlist: false),
            ),

            // ListView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   padding: EdgeInsets.all(8),
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: serviceProviders.length,
            //   itemBuilder: (context, index) {
            //     return SearchComponent(index,
            //         servicesModel: serviceProviders[index]);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
