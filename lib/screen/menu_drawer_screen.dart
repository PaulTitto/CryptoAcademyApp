import 'package:crypto_academy/provider/auth_provider.dart';
import 'package:crypto_academy/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDrawerScreen extends StatefulWidget {
  const MenuDrawerScreen({super.key});

  @override
  State<MenuDrawerScreen> createState() => _MenuDrawerScreenState();
}

class _MenuDrawerScreenState extends State<MenuDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 36, 24, 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 12),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Guest",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.maxFinite,
              height: 350,
              child: Column(
                children: [
                  _listIconSetting(Icons.share, "Share App"),
                  _listIconSetting(
                    Icons.account_balance_wallet_outlined,
                    "About Us",
                  ),
                  _listIconSetting(Icons.question_answer, "Questions"),
                  _listIconSetting(Icons.note, "Terms and Conditions"),
                  _listIconSetting(Icons.contact_phone, "Contact Us"),
                ],
              ),
            ),
            InkWell(
              focusColor: Colors.red,
              onTap: () async {
                await context.read<AuthProvider>().signOut();
                if (context.mounted) {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return LoginScreen();
                      }
                      ),
                      (Route<dynamic> route)=> false,
                  );
                }
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.exit_to_app, color: Colors.green),
                  ),
                  Text("Sign Out"),
                ],
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(220, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text("808", style: TextStyle(color: Colors.blueAccent)),
                    Text("- Support Service"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listIconSetting(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}
