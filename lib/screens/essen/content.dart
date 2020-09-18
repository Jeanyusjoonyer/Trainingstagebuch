import 'package:flutter/material.dart';
import 'package:trainingstagebuch/models/day.model.dart';

class Content extends StatefulWidget {
  final Day day;
  Content({this.day});
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.day.goal.toString()),
    );
  }
}
