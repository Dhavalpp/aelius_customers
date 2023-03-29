import 'package:flutter/material.dart';

import '../components/home_contruction_component.dart';
import '../utils/colors.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Services List",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding:const EdgeInsets.symmetric(horizontal: 16),
            //   child: Form(
            //     child: TextFormField(
            //       keyboardType: TextInputType.name,
            //       style:const TextStyle(fontSize: 17),
            //       decoration: commonInputDecoration(
            //         hintText: "Search for services",
            //         suffixIcon:const Icon(Icons.search, size: 18),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomeConstructionComponent(iconlist: false),
            ),
          ],
        ),
      ),
    );
  }
}
