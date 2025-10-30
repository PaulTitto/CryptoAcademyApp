import 'package:crypto_academy/screen/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget appBar(context) {
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
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditProfile()));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage(
              "assets/images/150.jpeg",
            ),
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
