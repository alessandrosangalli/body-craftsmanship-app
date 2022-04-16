import 'package:body_craftsmanship_app/provider/food_provider.dart';
import 'package:body_craftsmanship_app/routes/app_routes.dart';
import 'package:body_craftsmanship_app/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.foodForm);
                // foods.put(const Food(
                //   name: 'abc',
                //   kcal: 100,
                //   grams: 100,
                //   proteins: 10,
                //   carbohydrate: 10,
                //   fat: 10,
                // ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => FoodTile(foods.byIndex(i)),
        itemCount: foods.count,
      ),
    );
  }
}
