import 'package:flutter/material.dart';
import 'package:trainingstagebuch/models/food.model.dart';
import 'package:trainingstagebuch/models/unit.mode.dart';

class Details extends StatefulWidget {
  final Food food;
  final String title;
  Details({this.food, this.title});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = getUnitItems();
    Unit unit = widget.food.unit;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
        actions: [
          Icon(Icons.done),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(widget.food.name),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(widget.food.description),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Einheit"),
              trailing: DropdownButton(
                items: items,
                onChanged: (value) => setState(() =>
                    widget.food.unit = widget.food.getUnitWithName(value)),
                value: unit.name,
                style: TextStyle(color: Colors.blue, fontSize: 17),
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Menge"),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> getUnitItems() {
    List<DropdownMenuItem> res = [];
    widget.food.units.forEach((unit) {
      res.add(DropdownMenuItem(
        value: unit.name,
        child: Text(unit.name),
      ));
    });
    return res;
  }
}
