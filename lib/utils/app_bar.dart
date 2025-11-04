import 'package:crypto_academy/screen/edit_profile.dart';
import 'package:crypto_academy/screen/menu_drawer_screen.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(String title, bool iconButton, context) {
  return AppBar(
    elevation: 0,
    title: title == "" ? null : Text(title),

    leading: iconButton
        ? IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          )
        : null,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications_none_outlined),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfile()),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage("assets/images/150.jpeg"),
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MenuDrawerScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    var begin = Offset(1.0, -1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        },
        icon: Icon(Icons.menu),
      ),
    ],
  );
}
