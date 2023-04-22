import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thimage/config.dart';
import 'package:thimage/result_screen.dart';
import 'package:thimage/models.dart';

class PlayScreen extends StatefulWidget {
  final int numberOfPlayers;

  PlayScreen({Key? key, required this.numberOfPlayers}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  String _imageUrl = ""; // = 'assets/images/monkey.png';
  bool _isLoading = false;
  int _currentPlayer = 1;
  String _prompt = 'a nice monkey';
  final TextEditingController _textFieldController = TextEditingController();
  Map<int, String?> _playerImages = {};

  void _nextPlayer() {
    // Do something when the button is pressed
    setState(() {
      // Reset the value of the text field and remove the current displayed player
      _currentPlayer++;
      if (_currentPlayer > widget.numberOfPlayers) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                  numberOfPlayers: widget.numberOfPlayers,
                  playerImages: _playerImages)),
        );
      }
      _imageUrl = "";
      _textFieldController.clear();
    });
  }

  Future<void> _generateImage(String prompt) async {
    // Call REST API to generate image
    // ...
    setState(() {
      _isLoading = true;
    });

    // Replace with your actual API endpoint
    //const url = 'http://127.0.0.1:7860/sdapi/v1/txt2img';
    // API from 'http://127.0.0.1:7860/docs'
    Map<String, dynamic> bodyData =
        StableDiffusionModel(prompt: prompt).bodyData;

    try {
      final response = await http.post(Uri.parse(Constants.TXT2IMG_API_URL),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(bodyData));
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _imageUrl = responseData['images'][0];
          // TODO: save to cached network image

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        // Handle error
        print('Error: ${responseData['error']}');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      print('Error: $error');
    }

    //setState(() {
    //  _imageUrl = 'assets/images/monkey.png';
    //'https://example.com/image.jpg'; // Replace with actual URL of generated image
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Play Game'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Player N° $_currentPlayer out of ${widget.numberOfPlayers}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prompt',
                ),
              ),
              SizedBox(height: 10),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    String textFieldValue = _textFieldController.text;
                    _generateImage(textFieldValue);
                  },
                  child: Text('Generate Image'),
                ),
              ElevatedButton(
                onPressed: _imageUrl.isEmpty
                    ? null
                    : () {
                        // code to execute when the button is pressed
                        _playerImages[_currentPlayer] = _imageUrl;
                        _nextPlayer();
                      },
                child: Text('Next player'),
              ),
              SizedBox(height: 20),
              //if (!_imageUrl.isEmpty) Text("text is $_imageUrl"),
              if (!_imageUrl.isEmpty) Base64Image(base64String: _imageUrl),
              //if (_imageUrl != null)
              //  CachedNetworkImage(
              //    imageUrl: _imageUrl,
              //    placeholder: (context, url) => CircularProgressIndicator(),
              //    errorWidget: (context, url, error) => Icon(Icons.error),
              //  ),
              // Image.asset(
              //   _imageUrl, // Replace with the path to your image file
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ));
  }
}

class Base64Image extends StatelessWidget {
  final String base64String;

  const Base64Image({Key? key, required this.base64String}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decodedBytes = base64Decode(base64String);
    return Image.memory(
      decodedBytes,
      fit: BoxFit.cover,
    );
  }
}
