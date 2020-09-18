import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/services/auth.service.dart';

class FoodService {
  DateTime _time;
  AuthService _auth = AuthService();
  Day _day;
  FoodService() {
    _time = DateTime.now();
  }

  // change Date

  Future previousDay() async {
    _day = null;
    _time = DateTime(_time.year, _time.month, _time.day - 1);
    await fetchFood();
  }

  Future nextDay() async {
    _day = null;
    _time = DateTime(_time.year, _time.month, _time.day + 1);
    await fetchFood();
  }

  void setDate(DateTime date) {
    _time = date;
  }

  // getters

  String getDateString() {
    final now = DateTime.now();
    final check = DateTime(_time.year, _time.month, _time.day);
    if (check == DateTime(now.year, now.month, now.day)) {
      return "Heute";
    } else if (check == DateTime(now.year, now.month, now.day - 1)) {
      return "Gestern";
    } else if (check == DateTime(now.year, now.month, now.day + 1)) {
      return "Morgen";
    } else {
      return dateToString(_time);
    }
  }

  String dateToString(DateTime time) {
    final day = time.day;
    final month = time.month;
    final year = time.year;
    return "$day.$month.$year";
  }

  DateTime getDate() {
    return _time;
  }

  Day getFood() {
    return _day;
  }

  Future<void> fetchFood() async {
    try {
      final token = await _auth.getToken();
      var res = await http.get(
          "https://europe-west3-trainingstagebuch-f8308.cloudfunctions.net/food",
          headers: {
            "authorization": "Bearer " + token,
            "date": dateToString(_time)
          });
      if (res.statusCode == 200) {
        print("LOOK" + res.body);
        _day = Day.fromJson(json.decode(res.body));
      } else {
        print(res.body);
      }
    } catch (err) {
      print(err);
    }
  }
}
