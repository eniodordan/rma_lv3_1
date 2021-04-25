import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Color> birdColors = [
    Color(0xFF44C5CB),
    Color(0xFFFCE315),
    Color(0xFFF53D52),
    Color(0xFFFF9200),
  ];

  int birdCounter = 0;
  int latestBird = 0;

  void updateBirdCounter() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      birdCounter = (prefs.getInt('birdCounter') ?? 0);
    });
  }

  void updateLatestBird() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      latestBird = (prefs.getInt('latestBird') ?? 0);
    });
  }

  void incrementBirdCounter(int index) async {
    final prefs = await SharedPreferences.getInstance();

    int counter = (prefs.getInt('birdCounter') ?? 0) + 1;
    await prefs.setInt('birdCounter', counter);

    await prefs.setInt('latestBird', index);

    updateBirdCounter();
    updateLatestBird();
  }

  void resetBirdCounter() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('birdCounter');
    prefs.remove('latestBird');

    updateBirdCounter();
    updateLatestBird();
  }

  @override
  void initState() {
    super.initState();
    updateBirdCounter();
    updateLatestBird();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('rma_lv3_1'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$birdCounter',
                  style: TextStyle(
                    fontSize: 24,
                    color: birdColors[latestBird],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Bird #1'),
                      style: ElevatedButton.styleFrom(
                        primary: birdColors[0],
                      ),
                      onPressed: () {
                        incrementBirdCounter(0);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Bird #2'),
                      style: ElevatedButton.styleFrom(
                        primary: birdColors[1],
                      ),
                      onPressed: () {
                        incrementBirdCounter(1);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Bird #3'),
                      style: ElevatedButton.styleFrom(
                        primary: birdColors[2],
                      ),
                      onPressed: () {
                        incrementBirdCounter(2);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Bird #4'),
                      style: ElevatedButton.styleFrom(
                        primary: birdColors[3],
                      ),
                      onPressed: () {
                        incrementBirdCounter(3);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: () {
                    resetBirdCounter();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
