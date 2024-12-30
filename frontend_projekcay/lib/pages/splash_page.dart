import 'package:flutter/material.dart';
import 'package:frontend_projekcay/pages/login_page.dart'; // Pastikan path ini benar

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  // Fungsi untuk mengarahkan ke halaman Login setelah beberapa detik
  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3)); // Durasi 3 detik
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Pindah ke halaman LoginScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Latar belakang splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon untuk splash screen
            AnimatedRotation(
              turns: 1, // Putar satu kali penuh
              duration: const Duration(seconds: 2), // Durasi putaran
              child: const Icon(
                Icons.explore, // Ganti dengan icon yang sesuai
                size: 100, // Ukuran icon
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Adventure Bali',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore the Beauty of Bali',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
