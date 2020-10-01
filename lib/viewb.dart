import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Viewb extends StatefulWidget {
  final String url;
  Viewb(this.url);

  @override
  _ViewbState createState() => _ViewbState();
}

class _ViewbState extends State<Viewb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('       Web Screen',
              style: GoogleFonts.raleway(
                  fontSize: 30, letterSpacing: 1, color: Colors.black))),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
