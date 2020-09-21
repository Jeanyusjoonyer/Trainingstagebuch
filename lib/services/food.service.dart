import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/models/food.model.dart';

class FoodService {
  List<Food> food = [];

  Future<void> fetchFood() async {
    try {
      food = [];
      var res = await http.get(
          "https://europe-west3-trainingstagebuch-f8308.cloudfunctions.net/food");
      if (res.statusCode == 200) {
        final dynamic js = json.decode(res.body);
        js.forEach((element) {
          food.add(Food.fromJson(element));
        });
      } else {
        print(res.body);
      }
    } catch (err) {
      print(err);
    }
  }

  List<Widget> getFoodTiles(List<Food> meal, Day day, String mealName, update) {
    List<Widget> list = [];
    food.forEach((element) {
      list.add(ListTile(
        title: Text(element.name),
        subtitle: Text(element.description +
            ", " +
            element.amount.toString() +
            " " +
            element.unit.name),
        trailing: Text(element.calories.toString()),
        onTap: () => {day.addFoodtoMeal(element, mealName), update()},
      ));
      list.add(Divider());
    });
    return list;
  }

  List<Food> getFood() {
    return food;
  }
}
