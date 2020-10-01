import 'dart:io';

import 'package:NewsApp/newspage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Category> categorylist = [
    Category('Business', 'assets/buss.jpg'),
    Category('Sports', 'assets/sports.jpg'),
    Category('Health', 'assets/doctor.jpg'),
    Category('Entertainment', 'assets/enter.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: Text('Menu',
                style: GoogleFonts.sansita(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Colors.lightBlueAccent)),
          ),
          const Divider(
            color: Colors.white,
            height: 30,
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          SizedBox(height: 25),
          Container(
            height: 400,
            child: ListView(
              padding: EdgeInsets.all(1),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: categorylist.map((eachcategory) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsPage(eachcategory.name))),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
                        width: 65,
                        height: 65,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.pinkAccent, width: 1),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(eachcategory.image),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        eachcategory.name,
                        style: TextStyle(
                            color: Colors.grey.shade200, fontSize: 30),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 30,
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          SizedBox(height: 45),
          ContainedButton(
            onPressed: ()=> exit(0), child: Text('Exit',style: GoogleFonts.sansita(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Colors.white))),
                    SizedBox(height: 200,),
                    Text("©alokkaintura",style: GoogleFonts.raleway(
                    fontSize: 10,
                    letterSpacing: 3,
                    color: Colors.grey.shade300)),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String image;

  Category(this.name, this.image);
}
