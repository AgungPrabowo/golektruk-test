import 'package:flutter/material.dart';
import 'package:golektruk_test/screens/FirstScreen.dart';
import 'package:golektruk_test/screens/FourthScreen.dart';
import 'package:golektruk_test/screens/SecondScreen.dart';
import 'package:golektruk_test/screens/ThirdScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GolekTruk Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> questions = [
      FirstScreen(),
      SecondScreen(),
      ThirdScreen(),
      FourthScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final item = questions[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => item,
                ),
              );
            },
            child: ListTile(
              title: Text("Soal ${index + 1}"),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
