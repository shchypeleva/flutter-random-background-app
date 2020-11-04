import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class RandomColor extends Color {

  @override
  RandomColor({int value = 0}) : super(Random().nextInt(0xFFFFFFFF));

  @override
  RandomColor.fromRGBO({int r = 0, int g = 0, int b = 0, double opacity = 1.0}) : super.fromRGBO(
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextDouble());

  @override
  RandomColor.fromARGB({int a = 0, int r = 0, int g = 0, int b = 0}) : super.fromARGB(
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        secondaryHeaderColor: Colors.white,
      ),
      home: MyHomePage(title: 'Test task for Solid Software'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = new RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.launch,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                onPressed: (){
                  const URL = "https://solid.software";
                  _launchURL(URL);
                },
            ),
          ]
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Container(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _color = new RandomColor();
                    });
                  },
                  child: Container(
                    color: _color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Hey there',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.play(
                            fontSize: 30,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(50.0),
                  child: MaterialButton(
                    height: 40,
                    child: Text(
                      "Copy color",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => createAlertDialog(context).then((onValue){
                      final CopiedColorSnackBar = SnackBar(
                        content: Text("Color is copied to the clipboard"),
                        duration: Duration(seconds: 2),
                      );
                      Scaffold.of(context).showSnackBar(CopiedColorSnackBar);
                    }),
                  )
              ),
            ],
          );
        },
      ),
    );
  }


  Future createAlertDialog(BuildContext context) {

    return showDialog(context: context, builder: (context){
      return AlertDialog (
        title: Text("Copy background color"),
        actions: [
          FlatButton(
            child: Text(
              "Copy HEX",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _color.toHEX()));
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "Copy RGB",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _color.toRGB()));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}

_launchURL(String URL) async {
  if (await canLaunch(URL)){
    await launch(URL, forceWebView: true);
  } else {
    throw 'Could not launch $URL';
  }
}

extension ColorToHex on Color {
  String toHEX() {
    return '#${this.value.toRadixString(16).substring(2)}';
  }
}

extension ColorToRGB on Color {
  String toRGB() {
    return  '${((((255-(this.alpha)) * (Colors.white.red)) + (this.alpha * this.red))/255).round()} '
        '${((((255-(this.alpha)) * (Colors.white.green)) + (this.alpha * this.green))/255).round()} '
        '${((((255-(this.alpha)) * (Colors.white.blue)) + (this.alpha * this.blue))/255).round()}';
  }
}
