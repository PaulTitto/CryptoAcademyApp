import 'package:crypto_academy/provider/auth_provider.dart';
import 'package:crypto_academy/screen/home_screen.dart';
// import 'package:crypto_academy/screen/topics_list_screen.dart'; // Tidak terpakai di sini
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

  // --- SAYA BUAT FUNGSI TERPISAH AGAR 'onPressed' LEBIH RAPI ---
  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // 1. Validasi Sederhana
    if (email.isEmpty || password.isEmpty) {
      // Biarkan Firebase yang menangani error "empty" jika Anda mau,
      // atau set error di provider
      return;
    }

    // 2. Panggil signIn HANYA SATU KALI dan tunggu hasilnya
    //    Ini mengasumsikan signIn() di provider Anda mengembalikan Future<bool>
    bool loginBerhasil = await context.read<AuthProvider>().signIn(
      email,
      password,
    );

    // 3. JIKA login berhasil, BARU tampilkan dialog
    if (loginBerhasil && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false, // Opsional: paksa user klik OK
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Welcome $email")),
            // Gunakan 'content' untuk teks deskripsi
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
                onPressed: () {
                  // 4. Logika di dalam dialog SEKARANG SEDERHANA:
                  //    Hanya tutup dialog dan navigasi
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushReplacement( // Ganti layar, jangan push
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
    // 5. JIKA GAGAL (loginBerhasil == false):
    //    Tidak perlu 'else'. Consumer akan otomatis
    //    membangun ulang dan menampilkan 'auth.errorMessage'.
  }
  // --- AKHIR FUNGSI BANTUAN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        // Gunakan SingleChildScrollView agar tidak overflow saat keyboard muncul
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
                  // Tampilkan error DI ATAS tombol
                  if (auth.errorMessage.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      // Perjelas style error
                      child: Text(
                        auth.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  // Tampilkan loading DI ATAS tombol
                  if (auth.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // Widget ElevatedButton tidak saya ubah,
                  // hanya 'onPressed'-nya saja
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 50),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // Panggil fungsi yang sudah kita perbaiki
                    onPressed: _handleLogin,
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                },
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User?", style: TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: () {
                      // TODO: Tambahkan navigasi ke halaman Register
                    },
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