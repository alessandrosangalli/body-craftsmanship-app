import 'package:body_craftsmanship_app/provider/food_provider.dart';
import 'package:body_craftsmanship_app/routes/app_routes.dart';
import 'package:body_craftsmanship_app/widgets/food_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var foods = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.foodForm);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: FoodProvider.all,
            builder: (context, projectSnap) {
              final data = projectSnap.data as List<Food>;
              if (projectSnap.connectionState == ConnectionState.none &&
                      !projectSnap.hasData ||
                  projectSnap.data == null) {
                return const Text('No Data');
              }

              return ListView.builder(
                itemBuilder: (ctx, i) => FoodTile(data[i]),
                itemCount: data.length,
              );
            }),
      ),
    );
  }
}
