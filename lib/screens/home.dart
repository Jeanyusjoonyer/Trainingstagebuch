import 'package:flutter/material.dart';
import 'package:trainingstagebuch/screens/analyse.dart';
import 'package:trainingstagebuch/screens/essen.dart';
import 'package:trainingstagebuch/screens/sport.dart';
import 'package:trainingstagebuch/services/auth.service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 1;
  final _auth = AuthService();
  final content = [Essen(), Sport(), Analyse()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainingstagebuch"),
        leading: Icon(Icons.book),
        actions: [
          GestureDetector(
            child: Icon(Icons.exit_to_app),
            onTap: () => _logout(),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text("Essen")),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), title: Text("Sport")),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text("Analyse"))
        ],
        onTap: (value) => setState(() {
          this._index = value;
        }),
      ),
      body: content[_index],
    );
  }

  void _logout() async {
    await this._auth.signOut();
  }
}
