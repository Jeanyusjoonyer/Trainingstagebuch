class Day {
  String id, date, notes;
  int goal, current;
  List breakfast, lunch, dinner;
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
        breakfast = json['data']['breakfast'],
        lunch = json['data']['lunch'],
        dinner = json['data']['dinner'];

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

  int getRest() {
    return goal - current;
  }

  int sumMeal(dynamic meal) {
    int sum = 0;
    meal.forEach((element) {
      sum += element;
    });
    return sum;
  }

  void setNotes(String notes) {
    this.notes = notes;
  }
}
