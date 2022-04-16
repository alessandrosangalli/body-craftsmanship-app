import 'package:body_craftsmanship_app/models/food.dart';
import 'package:body_craftsmanship_app/provider/food_provider.dart';
import 'package:body_craftsmanship_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodTile extends StatelessWidget {
  final Food food;

  const FoodTile(this.food);

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundColor: Colors.grey,
      child: Text(food.name[0]),
    );

    return ListTile(
        leading: avatar,
        title: Text(food.name),
        subtitle: Text('${food.kcal} kcal'),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.foodForm, arguments: food);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check_box_outline_blank),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<FoodProvider>(context, listen: false)
                      .remove(food);
                },
                icon: const Icon(Icons.delete),
              ),
            ])));
  }
}
