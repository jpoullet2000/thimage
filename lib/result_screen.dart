import 'package:flutter/material.dart';
import 'package:thimage/play_screen.dart';
import 'package:thimage/config.dart';

class ResultScreen extends StatefulWidget {
  final int numberOfPlayers;
  final Map<int, String?> playerImages;

  const ResultScreen(
      {Key? key, required this.numberOfPlayers, required this.playerImages})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isCaptionVisible = false;
  late List<Map<String, dynamic>> shuffledImages;

  @override
  void initState() {
    super.initState();
    shuffledImages = List.generate(widget.playerImages.length, (index) {
      return {
        'index': index + 1,
        'image': widget.playerImages[index + 1],
      };
    })
      ..shuffle();
  }

  void _showCaption() {
    setState(() {
      _isCaptionVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _showCaption,
                  child: const Text('Show players'),
                ),
                SizedBox(
                  width: Constants.IMG_WIDTH.toDouble() * 2 + 16,
                  height: Constants.IMG_HEIGHT.toDouble() * 2 + 100,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(widget.numberOfPlayers, (index) {
                      return shuffledImages[index]['image'] !=
                              null // widget.playerImages[index + 1] != null
                          ? Card(
                              child: Stack(
                              children: [
                                Base64Image(
                                  base64String: shuffledImages[index]['image'],
                                ),
                                if (_isCaptionVisible)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      color:
                                          const Color.fromARGB(255, 71, 79, 192)
                                              .withOpacity(0.5),
                                      child: Text(
                                        'Player ${shuffledImages[index]['index']}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                              ],
                            ))
                          : Container();
                    }),
                  ),
                )
              ])),
    );
  }
}
