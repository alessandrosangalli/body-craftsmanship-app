import 'dart:ffi';

class Food {
  final int? id;
  final String name;
  final int kcal;
  final int grams;
  final int proteins;
  final int carbohydrate;
  final int fat;

  const Food({
    this.id,
    required this.name,
    required this.kcal,
    required this.grams,
    required this.proteins,
    required this.carbohydrate,
    required this.fat,
  });
}
