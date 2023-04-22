import 'package:flutter/material.dart';
import 'package:thimage/play_screen.dart';

class ResultScreen extends StatefulWidget {
  final int numberOfPlayers;
  final Map<int, String?> playerImages;

  ResultScreen(
      {Key? key, required this.numberOfPlayers, required this.playerImages})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _showCaption = false;

  void _show_caption() {
    setState(() {
      _showCaption = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _show_caption,
                  child: Text('Show players'),
                ),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(widget.numberOfPlayers, (index) {
                      return widget.playerImages[index + 1] != null
                          ? Stack(
                              children: [
                                if (_showCaption)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Color.fromARGB(255, 71, 79, 192)
                                          .withOpacity(0.5),
                                      child: Text(
                                        'Player ${index + 1}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Base64Image(
                                    base64String:
                                        widget.playerImages[index + 1]!,
                                  ),
                                ),
                              ],
                            )
                          : Container();
                    }),
                  ),
                )
              ])),
    );
  }
}
