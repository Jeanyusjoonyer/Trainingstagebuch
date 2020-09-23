import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/models/food.model.dart';
import 'package:trainingstagebuch/screens/essen/details.dart';

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

  List<Widget> getFoodTiles(BuildContext context, callback) {
    List<Widget> list = [];
    food.forEach((element) {
      list.add(
        ListTile(
            title: Text(element.name),
            subtitle: Text(element.description +
                ", " +
                element.amount.toString() +
                " " +
                element.unit.name),
            trailing: Text(element.getCalories().toString()),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(
                    food: Food.fromJson(
                        json.decode(json.encode(element.toJson()))),
                    origin: null,
                    title: "Nahrungsmittel hinzufügen",
                    mealCallback: callback,
                  ),
                ))),
      );
      list.add(Divider());
    });
    return list;
  }

  List<Food> getFood() {
    return food;
  }

  Future<String> addFood(Food food) async {
    try {
      var res = await http.post(
          "https://europe-west3-trainingstagebuch-f8308.cloudfunctions.net/food",
          body: {"food": json.encode(food.toJson())});

      if (res.statusCode == 200) {
        return res.body;
      } else {
        print(res.body);
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
