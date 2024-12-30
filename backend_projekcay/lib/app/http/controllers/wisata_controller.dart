import 'dart:io';
import 'package:backend_projekcay/app/models/wisata.dart';
import 'package:vania/vania.dart';

class WisataController extends Controller {
  // Create a new wisata
  Future<Response> create(Request request) async {
    request.validate({
      'name': "required",
      'description': "required",
      "location": "required",
      "photo_url": "url",
    }, {
      'name.required': "Nama tidak boleh kosong",
      'description.required': "Deskripsi tidak boleh kosong",
      'location.required': "Lokasi tidak boleh kosong",
      'photo_url.url': "URL foto tidak valid",
    });

    final name = request.input('name');
    final description = request.input('description');
    final location = request.input('location');
    final photoUrl = request.input('photo_url');

    await Wisata().query().insert({
      "name": name,
      "description": description,
      "location": location,
      "photo_url": photoUrl,
      "created_at": DateTime.now().toIso8601String(),
    });

    return Response.json({"message": "Wisata berhasil ditambahkan"}, 201);
  }

  // Get all wisatas
  Future<Response> index() async {
    final wisatas = await Wisata().query().get();
    return Response.json({
      "message": "Data wisata berhasil diambil",
      "data": wisatas,
    }, HttpStatus.ok);
  }

  // Get wisata by ID
  Future<Response> show(int id) async {
    final wisata = await Wisata().query().where('id', '=', id).first();

    if (wisata == null) {
      return Response.json({"message": "Wisata tidak ditemukan"}, 404);
    }

    return Response.json({
      "message": "Data wisata berhasil diambil",
      "data": wisata,
    });
  }

  // Update wisata by ID
  Future<Response> update(Request request, int id) async {
    try {
      // Debugging log
      print("Request untuk update ID: $id");
      print("Request data: ${request.all()}");

      // Validasi input
      request.validate({
        'name': "required",
        'description': "required",
        "location": "required",
        "photo_url": "url",
      }, {
        'name.required': "Nama tidak boleh kosong",
        'description.required': "Deskripsi tidak boleh kosong",
        'location.required': "Lokasi tidak boleh kosong",
        'photo_url.url': "URL foto tidak valid",
      });

      final name = request.input('name');
      final description = request.input('description');
      final location = request.input('location');
      final photoUrl = request.input('photo_url');

      // Cari wisata di database
      final wisata = await Wisata().query().where('id', '=', id).first();

      if (wisata == null) {
        print("Wisata dengan ID $id tidak ditemukan");
        return Response.json({"message": "Wisata tidak ditemukan"}, 404);
      }

      // Update data
      await Wisata().query().where('id', '=', id).update({
        "name": name,
        "description": description,
        "location": location,
        "photo_url": photoUrl,
        "updated_at": DateTime.now().toIso8601String(),
      });

      print("Wisata dengan ID $id berhasil diperbarui");
      return Response.json({"message": "Wisata berhasil diperbarui"});
    } catch (e) {
      print("Error saat memperbarui wisata: $e");
      return Response.json(
        {"message": "Terjadi kesalahan saat memperbarui data"},
        HttpStatus.internalServerError,
      );
    }
  }

  // Delete wisata by ID
  Future<Response> destroy(int id) async {
    try {
      final wisata = await Wisata().query().where('id', '=', id).first();

      if (wisata == null) {
        print("Wisata dengan ID $id tidak ditemukan");
        return Response.json({"message": "Wisata tidak ditemukan"}, 404);
      }

      await Wisata().query().where('id', '=', id).delete();

      print("Wisata dengan ID $id berhasil dihapus");
      return Response.json({"message": "Wisata berhasil dihapus"});
    } catch (e) {
      print("Error saat menghapus wisata: $e");
      return Response.json(
        {"message": "Terjadi kesalahan saat menghapus data"},
        HttpStatus.internalServerError,
      );
    }
  }
}

final WisataController wisataController = WisataController();
