import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/models/food.model.dart';
import 'package:trainingstagebuch/screens/essen/details.dart';
import 'package:trainingstagebuch/screens/essen/foodCreator.dart';
import 'package:trainingstagebuch/services/food.service.dart';

class FoodAdder extends StatefulWidget {
  final String title;
  final Day day;
  final updateCallback;
  FoodAdder({this.title, this.day, this.updateCallback});
  @override
  _FoodAdderState createState() => _FoodAdderState();
}

class _FoodAdderState extends State<FoodAdder> {
  final FoodService fs = FoodService();
  final _controller = TextEditingController();
  List<Widget> list = [];
  bool loading = true;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await fs.fetchFood();
    setState(() {
      loading = false;
      list = fs.getFoodTiles(context, check);
    });
  }

  update() {
    widget.updateCallback();
    Navigator.pop(context);
  }

  created(Food food) async {
    food.id = await fs.addFood(food);
    setState(() {
      fs.food.add(food);
      list = fs.getFoodTiles(context, check);
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(
            food: Food.fromJson(json.decode(json.encode(food.toJson()))),
            origin: null,
            title: "Nahrungsmittel hinzufügen",
            mealCallback: check,
          ),
        ));
  }

  check(Food origin, Food food) {
    setState(() {
      widget.day.addFoodtoMeal(food, widget.title);
    });
    Navigator.pop(context);
    Navigator.pop(context);
    widget.updateCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodCreator(
                    day: widget.day,
                    foodAdderCallback: created,
                  ),
                )),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: "Nahrungsmittel suchen",
                          hintStyle:
                              TextStyle(fontSize: 12, color: Colors.grey),
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => _controller.clear(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.center_focus_strong,
                    color: Colors.blue,
                    size: 35,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Filter:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    label: Icon(Icons.filter_list),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              Divider(),
            ],
          ),
          loading
              ? Expanded(
                  child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.blue,
                  ),
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: list,
                  ),
                )
        ],
      ),
    );
  }
}
