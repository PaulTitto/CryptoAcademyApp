import 'package:crypto_academy/utils/app_bar.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("",false,context),
      body: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 10),
                      controller: _searchBarController,
                      decoration: InputDecoration(
                        hintText: "Add a Comments..",
                        contentPadding: EdgeInsets.all(2),
                        suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "87 Comments",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 6),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 6,),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                      _commentsApp(
                          "assets/images/150.jpeg",
                          "David Green",
                          "20 Apr. 2021",
                          "😃😇Polygon has raised '\$450 million from strategic investors acco🤪rding to a press release sent to Bitcoin.com News on February 7."
                      ),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
    );
  }

  Widget _commentsApp(String image, String name, String date, String message){
    return Column(
      children: [
        SizedBox(height: 6),
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(name),
                    SizedBox(width: 10,),
                    Text(date, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Colors.grey))],
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
        SizedBox(height: 10),
        Divider(height: 1,)
      ]
    );
  }
}
