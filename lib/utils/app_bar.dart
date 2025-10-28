import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget appBar() {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_back),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications_none_outlined),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          radius: 12,
          backgroundImage: AssetImage(
            "assets/images/150.jpeg",
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
      ),
    ],
  );
}
