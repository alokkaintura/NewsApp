import 'dart:convert';

import 'package:NewsApp/viewb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:NewsApp/apikey.dart';

class NewsPage extends StatefulWidget {
  final String name;
  NewsPage(this.name);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  FlutterTts tts = FlutterTts();
  getnews() async {
    var url =
        //'https://gnews.io/api/v4/search?q=in&token=$apikey&category=${widget.name}';
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey&category=${widget.name}';
    var responce = await http.get(url);
    var result = jsonDecode(responce.body);
    List<News> newslist = List<News>();
    for (var article in result['articles']) {
      News news = News(article['title'], article['urlToImage'], article['url'],
          article['description']);
      newslist.add(news);
    }
    return newslist;
  }

  speak(String text) async {
    print(await tts.getLanguages);
    await tts.setLanguage('en-IN');
    await tts.setPitch(1);
    await tts.setVolume(1.0);
    await tts.speak(text);
  }

  bool liked = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Top ${widget.name} news",
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.lightBlueAccent,
                            letterSpacing: .5,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            FutureBuilder(
                future: getnews(),
                builder: (BuildContext context, dataSnapshot) {
                  if (!dataSnapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 170, vertical: 380),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text(
                            'please wait',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade200),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: dataSnapshot.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 15)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Viewb(
                                              dataSnapshot.data[index].url)));
                                },
                                child: Card(
                                  elevation: 12,
                                  child: Image(
                                      width: 380,
                                      height: 200,
                                      image: NetworkImage(
                                          dataSnapshot.data[index].image),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Text(dataSnapshot.data[index].title,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade200)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(dataSnapshot.data[index].description,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: Colors.grey.shade200)),
                              new Divider(
                                indent: 15,
                                color: Colors.grey.shade300,
                                endIndent: 15,
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                          liked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              liked ? Colors.red : Colors.grey),
                                      onPressed: () => _pressed()),
                                  InkWell(
                                      onTap: () =>
                                          speak(dataSnapshot.data[index].title),
                                      child: Icon(
                                        Icons.volume_up,
                                        size: 30,
                                        color: Colors.blue,
                                      )),
                                  /*InkWell(
                                      onTap: () async {
                                        await tts.stop();
                                      },
                                      child: Icon(Icons.stop)),*/
                                ],
                              )
                            ],
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}

class News {
  final String title;
  final String image;
  final String url;
  final String description;

  News(this.title, this.image, this.url, this.description);
}
