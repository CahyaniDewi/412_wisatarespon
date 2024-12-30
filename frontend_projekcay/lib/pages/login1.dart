// // login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:frontend_projekcay/pages/home_page.dart';  // Pastikan ini benar
// import 'package:frontend_projekcay/pages/register_page.dart';
// import 'package:frontend_projekcay/service/auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   void handleLogin() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Panggil fungsi login dan kirimkan data
//       await login(_emailController.text, _passwordController.text);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Login berhasil!")),
//       );

//       // Arahkan ke halaman HomeScreen dan kirim email sebagai data pengguna
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(userName: _emailController.text),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login gagal: $e")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF4CAF50), Color(0xFF1E88E5)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100),
//                   Image.network(
//                     'https://static.thenounproject.com/png/68979-200.png',
//                     height: 150,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Selamat Datang",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Silakan login untuk melanjutkan",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _emailController,
//                             decoration: const InputDecoration(
//                               labelText: "Email",
//                               prefixIcon: Icon(Icons.email),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           TextField(
//                             controller: _passwordController,
//                             decoration: const InputDecoration(
//                               labelText: "Password",
//                               prefixIcon: Icon(Icons.lock),
//                               border: OutlineInputBorder(),
//                             ),
//                             obscureText: true,
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: _isLoading ? null : handleLogin,
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: const Size(double.infinity, 50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               backgroundColor: const Color(0xFF1E88E5),
//                             ),
//                             child: Text(
//                               _isLoading ? "Loading..." : "Login",
//                               style: const TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegisterScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Belum punya akun? Daftar di sini.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
