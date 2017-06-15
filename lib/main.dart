import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as DartImage;
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    loadGif();
  }

  Uint8List _imageData = new Uint8List.fromList(new List());

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that
        // was created by the App.build method, and use it to set
        // our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Image(
          image: new MemoryImage(_imageData),
          width: 256.0,
          height: 256.0,
        ),
      ),
    );
  }

  Future<Null> loadGif() async {
    String url =
        "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif";
    var httpClient = createHttpClient();
    var response = await httpClient.readBytes(url);

    DartImage.Animation decodedGif = DartImage.decodeGifAnimation(response);
    DartImage.Image firstImage = decodedGif.toList().first;

    setState(() {
      print("Should draw image");
      _imageData = firstImage.getBytes();
    });
  }
}
