import 'package:crypto_academy/controllers/auth_gate.dart';
import 'package:crypto_academy/firebase_options.dart';
import 'package:crypto_academy/provider/auth_provider.dart';
import 'package:crypto_academy/provider/crypto_provider.dart';
import 'package:crypto_academy/screen/academy_screen.dart';
import 'package:crypto_academy/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CryptoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AuthGate(),
      ),
    );
  }
}
