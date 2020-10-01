import 'dart:convert';
import 'dart:io';
import 'package:NewsApp/apikey.dart';
import 'package:NewsApp/menu.dart';
import 'package:NewsApp/newspage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  /*final String name;
  Homepage(this.name);*/

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Category> categorylist = [
    Category('Business', 'assets/buss.jpg'),
    Category('Sports', 'assets/sports.jpg'),
    Category('Health', 'assets/doctor.jpg'),
    Category('Entertainment', 'assets/enter.jpg'),
  ];
  getnews() async {
    // var url = 'https://gnews.io/api/v4/search?q=in&token=$apikey&topic=science&lang=en';
    var url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey&lan=en";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(children: <Widget>[
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Colors.amber,width: 1),
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                        child: Text('Search Latest News',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600))),
                    width: 310,
                    height: 35,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 110,
                    child: ListView(
                      padding: EdgeInsets.all(1),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: categorylist.map((eachcategory) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsPage(eachcategory.name))),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(12),
                                width: 65,
                                height: 65,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.pinkAccent, width: 1),
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        image: AssetImage(eachcategory.image),
                                        fit: BoxFit.cover)),
                              ),
                              Text(
                                eachcategory.name,
                                style: TextStyle(color: Colors.grey.shade200),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  new Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 200)),
                      Text('Top Headlines-',
                          style: GoogleFonts.raleway(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.lightBlueAccent)),
                    ],
                  ),
                  SizedBox(height: 8),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        height: 555,
                        child: ListView(
                          children: [
                            Column(children: <Widget>[
                              FutureBuilder(
                                  future: getnews(),
                                  builder:
                                      (BuildContext context, dataSnapshot) {
                                    if (!dataSnapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 170, vertical: 200),
                                        child: Column(
                                          children: [
                                            CircularProgressIndicator(),
                                            Text(
                                              'wait a sec..',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade200),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: dataSnapshot.data.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: 120,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image(
                                                      image: NetworkImage(
                                                          dataSnapshot
                                                              .data[index]
                                                              .image),
                                                      fit: BoxFit.cover)),
                                              Container(
                                                color: Colors.transparent,
                                                margin: EdgeInsets.all(10),
                                                padding:
                                                    EdgeInsets.only(top: 11),
                                                width: 250,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                        dataSnapshot
                                                            .data[index].title,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade200,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.supervised_user_circle,
                            size: 22, color: Colors.grey.shade100),
                        Icon(Icons.feedback,
                            size: 22, color: Colors.grey.shade100),
                        Image(image: AssetImage('assets/home.gif')),
                        Icon(Icons.search,
                            size: 25, color: Colors.grey.shade100),
                        InkWell(
                            splashColor: Colors.orangeAccent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu()));
                            },
                            child: Icon(Icons.menu,
                                size: 25, color: Colors.grey.shade100)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]))));
  }
}

class Category {
  final String name;
  final String image;

  Category(this.name, this.image);
}

class News {
  final String title;
  final String image;
  final String url;
  final String description;

  News(this.title, this.image, this.url, this.description);
}
