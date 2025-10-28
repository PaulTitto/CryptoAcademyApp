import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subJudul;
  final String date;

  DetailScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subJudul,
    required this.date,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.menu)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.imagePath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.date, style: TextStyle(fontSize: 12)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.g_translate_outlined,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                widget.subJudul,
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
