import 'dart:convert';
import 'dart:math';

import 'package:body_craftsmanship_app/data/food_dummy.dart';
import 'package:body_craftsmanship_app/models/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodProvider with ChangeNotifier {
  static const _baseUrl =
      'https://body-craftsmanship-default-rtdb.firebaseio.com/';

  Future<void> put(Food food) async {
    var foodId = food.id;

    if (foodId != null) {
      await http.put("$_baseUrl/foods/$foodId/.json",
          body: json.encode({
            "name": food.name,
            "kcal": food.kcal,
            "grams": food.grams,
            "proteins": food.proteins,
            "carbohydrate": food.carbohydrate,
            "fat": food.fat,
          }));
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
    }

    notifyListeners();
  }

  Future<void> remove(Food food) async {
    if (food.id != null) {
      await http.delete("$_baseUrl/foods/${food.id}/.json");
      notifyListeners();
    }
  }

  static Future<List<Food>> get all async {
    final response = await http.get("$_baseUrl/foods.json");
    Map<String, dynamic> foods =
        json.decode(response.body) ?? <String, dynamic>{};
    var data = <Food>[];

    if (foods.isEmpty) return [];

    foods.forEach((key, value) {
      data.add(Food(
        id: key,
        name: value['name'],
        kcal: value['kcal'],
        grams: value['grams'],
        proteins: value['proteins'],
        carbohydrate: value['carbohydrate'],
        fat: value['fat'],
      ));
    });

    return data;
  }
}
