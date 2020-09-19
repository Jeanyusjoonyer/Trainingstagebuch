import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainingstagebuch/models/day.model.dart';
import 'package:trainingstagebuch/services/auth.service.dart';

class CaloriesService {
  DateTime _time;
  AuthService _auth = AuthService();
  Day _day;
  CaloriesService() {
    _time = DateTime.now();
  }

  // change Date

  Future setDate(DateTime date) async {
    _time = date;
    await fetchDay();
  }

  // getters

  DateTime getDate() {
    return _time;
  }

  Day getDay() {
    return _day;
  }

  String dateToString(DateTime time) {
    final day = time.day;
    final month = time.month;
    final year = time.year;
    return "$day.$month.$year";
  }

  Future<void> fetchDay() async {
    try {
      _day = null;
      final token = await _auth.getToken();
      var res = await http.get(
          "https://europe-west3-trainingstagebuch-f8308.cloudfunctions.net/calories",
          headers: {
            "authorization": "Bearer " + token,
            "date": dateToString(_time)
          });
      if (res.statusCode == 200) {
        _day = Day.fromJson(json.decode(res.body));
      } else {
        print(res.body);
      }
    } catch (err) {
      print(err);
    }
  }
}
