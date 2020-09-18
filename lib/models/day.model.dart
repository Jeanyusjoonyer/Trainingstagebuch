class Day {
  String id, date;
  int goal, current;
  List breakfast, lunch, dinner;
  Day(date, goal, current, breakfast, lunch, dinner, [id]);
  Day.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['data']['date'],
        goal = json['data']['goal'],
        current = json['data']['current'],
        breakfast = json['data']['breakfast'],
        lunch = json['data']['lunch'],
        dinner = json['data']['dinner'];
}
