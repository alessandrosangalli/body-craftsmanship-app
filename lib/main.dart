import 'package:body_craftsmanship_app/provider/food_provider.dart';
import 'package:body_craftsmanship_app/routes/app_routes.dart';
import 'package:body_craftsmanship_app/view/food/food_form.dart';
import 'package:body_craftsmanship_app/view/food/food_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => FoodProvider(),
      child: MaterialApp(
          title: 'Food',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            AppRoutes.foodForm: (_) => FoodForm(),
            AppRoutes.home: (_) => FoodList()
          }),
    );
  }
}
