import 'dart:convert';
import 'dart:math';

import 'package:body_craftsmanship_app/data/food_dummy.dart';
import 'package:body_craftsmanship_app/models/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodProvider with ChangeNotifier {
  static const _baseUrl =
      'https://body-craftsmanship-default-rtdb.firebaseio.com/';
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

  Future<void> put(Food food) async {
    if (food == null) {
      return;
    }

    var foodId = food.id;

    if (foodId != null && _items.containsKey(foodId)) {
      _items.update(foodId, (_) => food);
    } else {
      final response = await http.post("$_baseUrl/foods.json",
          body: json.encode({
            "name": food.name,
            "kcal": food.kcal,
            "grams": food.grams,
            "proteins": food.proteins,
            "carbohydrate": food.carbohydrate,
            "fat": food.fat,
          }));

      foodId = json.decode(response.body)['name'];

      _items.putIfAbsent(
          foodId!,
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
