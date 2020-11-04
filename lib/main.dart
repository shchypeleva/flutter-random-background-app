import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

extension RandomColor on Color{

  Color random(){
    return Color(Random().nextInt(0xFFFFFFFF));
  }
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
  Color _color = new Color(1).random();

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
                      _color = new Color(1).random();
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
              Clipboard.setData(ClipboardData(text: colorToHex(_color)));
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "Copy RGB",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: colorToRGB(_color)));
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

String colorToHex(Color color) {
  return  '#${color.value.toRadixString(16).substring(2)}';
}

String colorToRGB(Color color) {
  return  '${((((255-(color.alpha)) * (Colors.white.red)) + (color.alpha * color.red))/255).round()} '
          '${((((255-(color.alpha)) * (Colors.white.green)) + (color.alpha * color.green))/255).round()} '
          '${((((255-(color.alpha)) * (Colors.white.blue)) + (color.alpha * color.blue))/255).round()}';
}