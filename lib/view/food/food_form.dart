import 'package:body_craftsmanship_app/models/food.dart';
import 'package:body_craftsmanship_app/provider/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FoodForm extends StatefulWidget {
  FoodForm({Key? key}) : super(key: key);

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  void _loadFormData(Food food) {
    _formData['id'] = food.id;
    _formData['name'] = food.name;
    _formData['kcal'] = food.kcal;
    _formData['grams'] = food.grams;
    _formData['proteins'] = food.proteins;
    _formData['carbohydrate'] = food.carbohydrate;
    _formData['fat'] = food.fat;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null) {
      final Food food = arguments as Food;
      _loadFormData(food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _form.currentState?.save();

                Provider.of<FoodProvider>(context, listen: false).put(
                  Food(
                      id: _formData['id'],
                      name: _formData['name'],
                      kcal: _formData['kcal'],
                      grams: _formData['grams'],
                      proteins: _formData['proteins'],
                      carbohydrate: _formData['carbohydrate'],
                      fat: _formData['fat']),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['grams'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Grams'),
                onSaved: (value) =>
                    _formData['grams'] = int.parse(value ?? '0'),
              ),
              TextFormField(
                initialValue: _formData['kcal'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Kcal'),
                onSaved: (value) => _formData['kcal'] = int.parse(value ?? '0'),
              ),
              TextFormField(
                initialValue: _formData['proteins'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Proteins'),
                onSaved: (value) =>
                    _formData['proteins'] = int.parse(value ?? '0'),
              ),
              TextFormField(
                initialValue: _formData['carbohydrate'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Carbohydrate'),
                onSaved: (value) =>
                    _formData['carbohydrate'] = int.parse(value ?? '0'),
              ),
              TextFormField(
                initialValue: _formData['fat'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Fat'),
                onSaved: (value) => _formData['fat'] = int.parse(value ?? '0'),
              ),
            ]),
          )),
    );
  }
}
