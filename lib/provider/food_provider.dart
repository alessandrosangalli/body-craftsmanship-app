import 'dart:math';

import 'package:body_craftsmanship_app/data/food_dummy.dart';
import 'package:body_craftsmanship_app/models/food.dart';
import 'package:flutter/material.dart';

class FoodProvider with ChangeNotifier {
  final Map<int, Food> _items = {...DUMMY_FOOD};

  List<Food> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Food byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Food food) {
    if (food == null) {
      return;
    }

    var foodId = food.id;

    if (foodId != null && _items.containsKey(foodId)) {
      _items.update(foodId, (_) => food);
    } else {
      foodId = Random().nextInt(10);

      _items.putIfAbsent(
          foodId,
          () => Food(
                id: foodId,
                name: food.name,
                kcal: food.kcal,
                grams: food.grams,
                proteins: food.proteins,
                carbohydrate: food.carbohydrate,
                fat: food.fat,
              ));
    }

    notifyListeners();
  }

  void remove(Food food) {
    if (food != null && food.id != null) {
      _items.remove(food.id);
      notifyListeners();
    }
  }
}
