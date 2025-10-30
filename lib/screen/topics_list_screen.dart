import 'package:crypto_academy/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:crypto_academy/utils/app_bar.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({super.key});

  @override
  State<TopicsListScreen> createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/9-250x250.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              _columnList(
                "assets/images/9-250x250.jpg",
                "What is Bitcoin?",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),
              _columnList(
                "assets/images/9-250x250.jpg",
                "Who created Bitcoin?",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),

              _columnList(
                "assets/images/9-250x250.jpg",
                "How Bitcoin works?",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),

              _columnList(
                "assets/images/9-250x250.jpg",
                "How to get Bitcoin",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),
              _columnList(
                "assets/images/9-250x250.jpg",
                "How to use Bitcoin",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),
              _columnList(
                "assets/images/9-250x250.jpg",
                "What is Bitcoin?",
                "The world’s first widely-adopted cryptocurrency. With Bitcoin .....",
                "Aug 12, 2021",
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _columnList(
    String imagePath,
    String title,
    String subJudul,
    String date,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              imagePath: imagePath,
              title: title,
              subJudul: subJudul,
              date: date,
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 84,
                width: 84,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    subJudul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),

                  Text(
                    date,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
