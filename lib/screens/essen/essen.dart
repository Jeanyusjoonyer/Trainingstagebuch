import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainingstagebuch/screens/essen/content.dart';
import 'package:trainingstagebuch/screens/essen/header.dart';
import 'package:trainingstagebuch/services/calories.service.dart';

class Essen extends StatefulWidget {
  @override
  EssenState createState() => EssenState();
}

class EssenState extends State<Essen> {
  final CaloriesService _cs = CaloriesService();
  Widget _statecontent = SpinKitThreeBounce(
    color: Colors.blue,
  );

  @override
  void initState() {
    setDate(new DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
    super.initState();
  }

  setDate(DateTime date) async {
    setState(() {
      _statecontent = SpinKitThreeBounce(color: Colors.blue);
    });
    await _cs.setDate(date);
    if (_cs.getDay() != null) {
      setState(() {
        _statecontent = Content(
          day: _cs.getDay(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Header(
            date: _cs.getDate(),
            callback: setDate,
          ),
          Expanded(
            child: _statecontent,
          ),
        ],
      ),
    );
  }
}
