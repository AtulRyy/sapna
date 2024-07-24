import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<String> fetchAffirmation() async {
      final response =
          await http.get(Uri.parse('https://www.affirmations.dev/'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['affirmation'];
      } else {
        throw Exception('Failed to load affirmation');
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFF3FEB8),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bg-circles.png',
              fit: BoxFit.none,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text("Sapna",
                      style: GoogleFonts.playball(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 43))),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.notifications, size: 30),
                      onPressed: () {
                        // Action when the bell icon is pressed
                      },
                    ),
                  ],
                ),
                greeting(),
                // const SizedBox(
                //   height: 20,
                // ),
                affieContainer(fetchAffirmation),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: GoogleFonts.piazzolla(
                            textStyle:
                                TextStyle(fontSize: 25, color: Colors.black)),
                      ),
                      Text(
                        "20th July",
                        style: GoogleFonts.piazzolla(
                            textStyle: TextStyle(
                                fontSize: 25, color: Color(0xFFFFB22C))),
                      )
                    ],
                  ),
                ),
                StudentItem(),
                StudentItem(),
                StudentItem(),
                StudentItem()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container StudentItem() {
    return Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 13),
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  color: Color(0xFFFFDE4D),
                  image: DecorationImage(
                      image: AssetImage('assets/images/childCardBg.png'),
                      alignment: Alignment.centerRight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/childImage.png'),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emmanuel J",
                          style: GoogleFonts.piazzolla(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900)),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 17),
                              child: Text("Class 4",style: GoogleFonts.piazzolla(
                          textStyle:TextStyle(
                            fontSize: 16,
                            color: Color(0xFF555555)
                            
                          )
                        ),),
                            ),
                            Text("Level 4",style: GoogleFonts.piazzolla(
                          textStyle:TextStyle(
                            fontSize: 16,
                            color: Color(0xFF555555)
                            
                          )
                        ),)
                          ],
                        ),
                        Text("Integers and Number-Line",style: GoogleFonts.piazzolla(
                          textStyle:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            );
  }

  Container greeting() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 55),
      child: Column(
        children: [
          Text("Hey There,",
              style: GoogleFonts.piazzolla(
                  textStyle: TextStyle(
                fontSize: 21,
              ))),
          Text(
            "Atul!",
            style: GoogleFonts.piazzolla(
                textStyle:
                    TextStyle(fontSize: 41, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Container affieContainer(Future<String> fetchAffirmation()) {
    return Container(
      padding: EdgeInsets.only(right: 15, left: 15, top: 22, bottom: 10),
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
          color: Color(0xFFFFB22C),
          image: DecorationImage(
              image: AssetImage(
                'assets/images/affie-background.png',
              ),
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomRight),
          borderRadius: BorderRadiusDirectional.all(Radius.circular(34))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Here's an ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "Affie!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFF4C4C),
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
                
                FutureBuilder<String>(
                  future: fetchAffirmation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        "Stay positive and happy!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return Text(
                        "Stay positive and happy!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            'assets/images/teamSpirit.png',
            width: 156,
            height: 168,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
