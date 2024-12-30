import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.0.112:8000/api'; // Ganti dengan URL API yang sesuai

// Kelas untuk mengelola operasi wisata
class WisataService {
  // Fungsi untuk mengambil daftar wisata
  static Future<List<Map<String, dynamic>>> fetchWisata() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wisatas'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']); // Ambil array 'data'
      } else {
        throw Exception('Failed to load wisata');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Fungsi untuk mengambil detail wisata berdasarkan ID
  static Future<Map<String, dynamic>> getWisataDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wisatas/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']; // Ambil data detail wisata
      } else {
        throw Exception('Failed to load wisata detail');
      }
    } catch (e) {
      throw Exception('Error fetching wisata detail: $e');
    }
  }

  
  // Fungsi untuk menambah wisata baru
static Future<void> addWisata(String name, String description, String photoUrl, String location) async {
  try {
    // Validasi data sebelum dikirim ke server
    if (name.isEmpty || description.isEmpty || location.isEmpty || photoUrl.isEmpty) {
      throw Exception('Semua kolom harus diisi');
    }

    // Mengirim request POST ke API
    final response = await http.post(
      Uri.parse('$baseUrl/wisatas/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'description': description,
        'location': location,
        'photo_url': photoUrl,
      }),
    );

    // Cek status code untuk menentukan apakah berhasil atau gagal
    if (response.statusCode == 201) {
      print('Wisata added successfully!');
    } else {
      print('Failed to add wisata: ${response.body}');
      throw Exception('Failed to add wisata');
    }
  } catch (e) {
    print("Error adding wisata: $e");
  }
}


  // Fungsi untuk memperbarui wisata
  static Future<void> updateWisata(int id, String name, String description, String photoUrl, String location) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/wisatas/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'description': description,
          'location': location, // Menambahkan lokasi untuk update
          'photo_url': photoUrl,

        }),
      );

      if (response.statusCode == 200) {
        print('Wisata updated successfully!');
      } else {
        print('Failed to update wisata: ${response.body}');
        throw Exception('Failed to update wisata');
      }
    } catch (e) {
      print("Error updating wisata: $e");
    }
  }

  // Fungsi untuk menghapus wisata
  static Future<void> deleteWisata(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/wisatas/$id'));

      if (response.statusCode == 200) {
        print('Wisata deleted successfully!');
      } else {
        print('Failed to delete wisata: ${response.body}');
        throw Exception('Failed to delete wisata');
      }
    } catch (e) {
      print("Error deleting wisata: $e");
    }
  }
}
