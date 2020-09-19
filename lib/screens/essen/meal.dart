import 'package:flutter/material.dart';
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/screens/essen/foodAdder.dart';

class Meal extends StatefulWidget {
  final dynamic meal;
  final Day day;
  final String title;
  Meal({this.day, this.meal, this.title});
  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                    child: Text(
                  widget.day.sumMeal(widget.meal).toString(),
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.end,
                )),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodAdder(
                        title: widget.title,
                      ))),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Nahrungsmittel hinzufügen",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
