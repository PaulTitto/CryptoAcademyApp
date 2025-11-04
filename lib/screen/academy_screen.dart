import 'package:crypto_academy/utils/app_bar.dart';
import 'package:flutter/material.dart';

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({super.key});

  @override
  State<AcademyScreen> createState() => _AcademyScreenState();
}

class _AcademyScreenState extends State<AcademyScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchBarController = TextEditingController();
    return Scaffold(
      appBar: appBar("Academy", false, context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 24),
                  child: SearchBar(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12)
                      )
                    ),
                    hintText: "Search...",
                    controller: _searchBarController,
                    trailing: <Widget>[
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.search)
                      )
                    ],
                  )),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                  child: Text("My Course")
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _course("PHP", Colors.blueAccent, "assets/images/150.jpeg"),
                    _course("PHP", Colors.blueAccent, "assets/images/150.jpeg"),
                    _course("PHP", Colors.blueAccent, "assets/images/150.jpeg"),
                    _course("PHP", Colors.blueAccent, "assets/images/150.jpeg"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Categories"), Text("See All")],
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _categoires(
                      "assets/images/150.jpeg",
                      "Cryptocurrency",
                      "126",
                      Colors.blueAccent,
                    ),
                    _categoires(
                      "assets/images/150.jpeg",
                      "Cryptocurrency",
                      "126",
                      Colors.blueAccent,
                    ),
                    _categoires(
                      "assets/images/150.jpeg",
                      "Cryptocurrency",
                      "126",
                      Colors.blueAccent,
                    ),
                    _categoires(
                      "assets/images/150.jpeg",
                      "Cryptocurrency",
                      "126",
                      Colors.blueAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Recent")
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _recent(
                      "Non-fungible token (NFT)",
                      Colors.blueAccent,
                      "assets/images/150.jpeg",
                      "126",
                      "46",
                    ),
                    _recent(
                      "PHP",
                      Colors.blueAccent,
                      "assets/images/150.jpeg",
                      "126",
                      "46",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _glossarry(
                        "Non-fungible token (NFT)",
                        Colors.blueAccent,
                        "assets/images/150.jpeg",
                        "126",
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _course(String nameCourse, Color color, String image) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 222,
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(nameCourse),
                    CircularProgressIndicator(value: 1, color: Colors.white),
                  ],
                ),
              ),
              Expanded(child: Image.asset(image)),
            ],
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _recent(
    String nameCourse,
    Color color,
    String image,
    String topics,
    String video,
  ) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 320,
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        nameCourse,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Text(
                            "$topics Topics",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "$video Video",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(image),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _categoires(String image, String name, String topics, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
          ),
          width: 100,
          height: 107,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(image),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$topics Topics",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }


  Widget _glossarry(
      String nameCourse,
      Color color,
      String image,
      String word,
      ) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 350,
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10,10,0,10),
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(image),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,10,10,10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameCourse,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "$word Topics",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
