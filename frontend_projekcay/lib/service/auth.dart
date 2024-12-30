import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const secureStorage = FlutterSecureStorage();

const String baseUrl = 'http://192.168.0.112:8000/api'; // Ganti IP dengan IP host laptop

// Fungsi Login
Future<void> login(String email, String password) async {
  final url = Uri.parse('$baseUrl/auth/login');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['token']['access_token'];

      await secureStorage.write(key: 'access_token', value: accessToken);
      print('Access token successfully stored!');
    } else {
      final error = json.decode(response.body);
      throw Exception('Login failed: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('Login failed: $e');
  }
}

// Fungsi Registrasi
Future<void> register(String name, String email, String password, String passwordConfirmation) async {
  final url = Uri.parse('$baseUrl/auth/register');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 201) {
      print('Registration successful!');
    } else {
      final error = json.decode(response.body);
      throw Exception('Registration failed: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('Registration failed: $e');
  }
}

  Future<Map<String, dynamic>> fetchProtectedData() async {
  final accessToken = await secureStorage.read(key: 'access_token');
  if (accessToken == null) {
    throw Exception('Token akses tidak ditemukan');
  }

  // print('Access Token: $accessToken'); // Tambahkan log ini

  final url = Uri.parse('$baseUrl/me');
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Pastikan response body sesuai dengan struktur data yang diinginkan
    } else {
      throw Exception('Gagal mengambil data: ${response.body}');
    }
  } catch (e) {
    throw Exception('Terjadi kesalahan: $e');
  }
}


// Fungsi Logout
Future<void> logout() async {
  await secureStorage.delete(key: 'access_token');
  print('Access token successfully deleted.');
}

// Fungsi Update Wisata
Future<void> updateWisata(int id, String name, String description, String photoUrl) async {
  final url = Uri.parse('$baseUrl/wisatas/$id');
  final accessToken = await secureStorage.read(key: 'access_token');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'name': name,
        'description': description,
        'photo_url': photoUrl,
      }),
    );

    if (response.statusCode == 200) {
      print('Wisata updated successfully!');
    } else {
      final error = json.decode(response.body);
      throw Exception('Failed to update wisata: ${error['message'] ?? 'Server error'}');
    }
  } catch (e) {
    throw Exception('Error updating wisata: $e');
  }
}
