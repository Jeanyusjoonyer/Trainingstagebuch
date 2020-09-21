import 'package:trainingstagebuch/models/unit.mode.dart';

class Food {
  String name, description, id;
  Unit unit;
  List<Unit> units;
  int calories;
  double carbs, fats, protein, amount;
  Food(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.units,
      this.calories,
      this.carbs,
      this.fats,
      this.protein,
      this.amount});
  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        unit = Unit.fromJson(json['unit']),
        units = transform(json['units']),
        calories = json['calories'].toInt(),
        carbs = json['carbs'].toDouble(),
        fats = json['fats'].toDouble(),
        protein = json['protein'].toDouble(),
        amount = json['amount'].toDouble();

  Map<String, Object> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "unit": unit,
        "units": units,
        "calories": calories,
        "carbs": carbs,
        "protein": protein,
        "fats": fats,
        "amount": amount
      };

  static List<Unit> transform(List list) {
    List<Unit> res = [];
    list.forEach((unit) {
      res.add(Unit.fromJson(unit));
    });
    return res;
  }

  Unit getUnitWithName(String name) {
    Unit res;
    units.forEach((unit) {
      if (unit.name == name) {
        res = unit;
      }
    });
    return res;
  }
}
