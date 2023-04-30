import 'package:flutter/material.dart';
import 'package:thimage/play_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _numberOfPlayers = 1;

  void _incrementPlayerCount() {
    setState(() {
      _numberOfPlayers++;
    });
  }

  void _decrementPlayerCount() {
    setState(() {
      _numberOfPlayers--;
    });
  }

  void _startPlaying() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlayScreen(numberOfPlayers: _numberOfPlayers)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Number of Players'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Number of Players:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_numberOfPlayers',
              style: TextStyle(fontSize: 48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed:
                      _numberOfPlayers > 1 ? _decrementPlayerCount : null,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementPlayerCount,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPlaying,
              child: Text('Start playing'),
            ),
          ],
        ),
      ),
    );
  }
}
