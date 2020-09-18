import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainingstagebuch/screens/essen/content.dart';
import 'package:trainingstagebuch/services/food.service.dart';

class Essen extends StatefulWidget {
  @override
  _EssenState createState() => _EssenState();
}

class _EssenState extends State<Essen> {
  final FoodService _fs = FoodService();
  Widget _statecontent = SpinKitThreeBounce(
    color: Colors.blue,
  );

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await _fs.fetchFood();
    if (_fs.getFood() != null) {
      setState(() {
        _statecontent = Content(
          day: _fs.getFood(),
        );
      });
    }
  }

  previous() async {
    setState(() {
      _statecontent = SpinKitThreeBounce(color: Colors.blue);
    });
    await _fs.previousDay();
    if (_fs.getFood() != null) {
      setState(() {
        _statecontent = Content(
          day: _fs.getFood(),
        );
      });
    }
  }

  next() async {
    setState(() {
      _statecontent = SpinKitThreeBounce(color: Colors.blue);
    });
    await _fs.nextDay();
    if (_fs.getFood() != null) {
      setState(() {
        _statecontent = Content(
          day: _fs.getFood(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: SizedBox(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.blue,
                  ),
                  width: 70,
                  height: 50,
                ),
                onTap: () async => await previous(),
              ),
              InkWell(
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Text(
                      _fs.getDateString(),
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ),
                onTap: () => {
                  showDatePicker(
                          context: context,
                          initialDate: _fs.getDate(),
                          firstDate: DateTime(1920),
                          lastDate: DateTime(2100))
                      .then((value) => setState(
                          () => {if (value != null) _fs.setDate(value)}))
                },
              ),
              InkWell(
                child: SizedBox(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                  ),
                  width: 70,
                  height: 50,
                ),
                onTap: () => next(),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            child: _statecontent,
          ),
        ],
      ),
    );
  }
}
