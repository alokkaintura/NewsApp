import 'dart:async';
import 'package:NewsApp/home.dart';
import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
      // theme: ThemeData.dark(),
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      home: Splash(),
    ));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Image(image: AssetImage('assets/')),
          SizedBox(height: 300),
          Image(image: AssetImage('assets/ne.gif'))
        ],
      ),
    );
  }
}
