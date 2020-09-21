import 'package:trainingstagebuch/models/food.model.dart';

class Day {
  String id, date, notes;
  int goal, current;
  List<Food> breakfast, lunch, dinner;
  Day(
      {this.date,
      this.notes,
      this.goal,
      this.current,
      this.breakfast,
      this.lunch,
      this.dinner,
      this.id});
  Day.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['data']['date'],
        notes = json['data']['notes'],
        goal = json['data']['goal'],
        current = json['data']['current'],
        breakfast = transform(json['data']['breakfast']),
        lunch = transform(json['data']['lunch']),
        dinner = transform(json['data']['dinner']);

  Map<String, Object> toJson() => {
        "id": id,
        "date": date,
        "notes": notes,
        "goal": goal,
        "current": current,
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner
      };

  static List<Food> transform(List list) {
    List<Food> res = [];
    list.forEach((food) {
      res.add(Food.fromJson(food));
    });
    return res;
  }

  int getRest() {
    return goal - current;
  }

  int sumMeal(List<Food> meal) {
    int sum = 0;
    meal.forEach((food) {
      sum += food.calories;
    });
    return sum;
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  void addFoodtoMeal(Food food, String mealName) {
    switch (mealName) {
      case "Frühstück":
        breakfast.add(food);
        break;
      case "Mittagessen":
        lunch.add(food);
        break;
      case "Abendessen":
        dinner.add(food);
        break;
    }
    current += food.calories;
  }

  void removeFoodfromMeal(Food food, String mealName) {
    switch (mealName) {
      case "Frühstück":
        breakfast.remove(food);
        break;
      case "Mittagessen":
        lunch.remove(food);
        break;
      case "Abendessen":
        dinner.remove(food);
        break;
    }
    current -= food.calories;
  }

  void moveMeal(Food food, String from, String to) {
    if (from != to) {
      removeFoodfromMeal(food, from);
      addFoodtoMeal(food, to);
    }
  }

  List<Food> getMealFromName(String name) {
    switch (name) {
      case "Frühstück":
        return breakfast;
        break;
      case "Mittagessen":
        return lunch;
        break;
      case "Abendessen":
        return dinner;
        break;
      default:
        return null;
    }
  }
}
