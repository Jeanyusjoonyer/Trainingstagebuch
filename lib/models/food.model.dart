class Food {
  String name, description, unit, id;
  int calories;
  double carbs, fats, protein, amount;
  Food(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.calories,
      this.carbs,
      this.fats,
      this.protein,
      this.amount});
  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['data']['name'],
        description = json['data']['description'],
        unit = json['data']['unit'],
        calories = json['data']['calories'].toInt(),
        carbs = json['data']['carbs'].toDouble(),
        fats = json['data']['fats'].toDouble(),
        protein = json['data']['protein'].toDouble(),
        amount = json['data']['amount'].toDouble();

  Map<String, Object> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "unit": unit,
        "calories": calories,
        "carbs": carbs,
        "protein": protein,
        "fats": fats,
        "amount": amount
      };
}
