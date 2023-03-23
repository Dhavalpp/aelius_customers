import 'package:flutter/material.dart';

import '../components/favorite_service_component.dart';
import '../models/service_provider_model.dart';
import '../utils/colors.dart';

class FavouriteProvidersScreen extends StatefulWidget {
  const FavouriteProvidersScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteProvidersScreen> createState() =>
      _FavouriteProvidersScreenState();
}

class _FavouriteProvidersScreenState extends State<FavouriteProvidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title:const Text(
          "Favorite Service Providers",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FavoriteServiceComponent(
            index,
            serviceProviderModel: likedProviders[index % likedProviders.length],
          );
        },
      ),
    );
  }
}
