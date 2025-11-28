import 'package:crypto_academy/provider/auth_provider.dart';
import 'package:crypto_academy/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isChecked = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogle() async {
    final authProvider = context.read<AuthProvider>();

    final userCredential = await authProvider.signInWithGoogle();

    if (userCredential == null) {
      return;
    }

    if (context.mounted) {
      String displayName = userCredential.user?.displayName ?? "User";

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Welcome $displayName")),
            content: Text(
              "We are glad to see you in our community. Here you will learn everything you need to know about cryptocurrency",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(200, 40),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    bool loginBerhasil = await authProvider.signIn(email, password);

    if (loginBerhasil && context.mounted) {
      String displayName = authProvider.user?.displayName ?? email;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Welcome $displayName")),
            content: Text(
              "We are glad to see you in our community. Here you will learn everything you need to know about cryptocurrency",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(200, 40),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Image.asset("assets/images/logo.png", width: 100, height: 80),
              SizedBox(height: 20.0),
              Text(
                "Log In",
                style: TextStyle(fontFamily: 'Rubik', fontSize: 20),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                controller: _emailController,
                onChanged: (_) => context.read<AuthProvider>().clearError(),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                controller: _passwordController,
                onChanged: (_) => context.read<AuthProvider>().clearError(),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      Text("Remember"),
                    ],
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  if (auth.errorMessage.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        auth.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (auth.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _handleLogin,
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _handleGoogle,
                        child: Text(
                          "Log In with Google",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User?", style: TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: () {},
                    child: Text("Register", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
