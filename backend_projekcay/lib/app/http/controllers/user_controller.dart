import 'dart:io';
import 'package:backend_projekcay/app/models/user.dart';
import 'package:vania/vania.dart';

class UserController extends Controller {
  // Create a new user
  Future<Response> create(Request request) async {
    request.validate({
      'name': "required",
      'email': "required|email",
      "password": "required|min_length:6|confirmed",
    }, {
      'name.required': "Nama tidak boleh kosong",
      'email.required': "Email tidak boleh kosong",
      'email.email': "Format email tidak valid",
      'password.required': "Password tidak boleh kosong",
      'password.min_length': "Password harus minimal 6 karakter",
      'password.confirmed': "Konfirmasi password tidak sesuai",
    });

    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password').toString();

    var existingUser = await User().query().where('email', '=', email).first();
    if (existingUser != null) {
      return Response.json({
        "message": "Email sudah terdaftar",
      }, 409);
    }

    password = Hash().make(password);

    await User().query().insert({
      "name": name,
      "email": email,
      "password": password,
      "created_at": DateTime.now().toIso8601String(),
    });

    return Response.json({"message": "User berhasil ditambahkan"}, 201);
  }

  // Get all users
  Future<Response> index() async {
    final users = await User().query().select(['id', 'name', 'email', 'created_at']).get();
    return Response.json({
      "message": "Data user berhasil diambil",
      "data": users,
    }, HttpStatus.ok);
  }

  // Get user by ID
  Future<Response> show(int id) async {
    final user = await User().query().select(['id', 'name', 'email', 'created_at']).where('id', '=', id).first();

    if (user == null) {
      return Response.json({"message": "User tidak ditemukan"}, 404);
    }

    return Response.json({
      "message": "Data user berhasil diambil",
      "data": user,
    });
  }

  // Update user by ID
  Future<Response> update(Request request, int id) async {
    request.validate({
      'name': "required",
      'email': "required|email",
    }, {
      'name.required': "Nama tidak boleh kosong",
      'email.required': "Email tidak boleh kosong",
      'email.email': "Format email tidak valid",
    });

    final name = request.input('name');
    final email = request.input('email');

    final user = await User().query().where('id', '=', id).first();
    if (user == null) {
      return Response.json({"message": "User tidak ditemukan"}, 404);
    }

    await User().query().where('id', '=', id).update({
      "name": name,
      "email": email,
      "updated_at": DateTime.now().toIso8601String(),
    });

    return Response.json({"message": "User berhasil diperbarui"});
  }

  // Delete user by ID
  Future<Response> destroy(int id) async {
    final user = await User().query().where('id', '=', id).first();

    if (user == null) {
      return Response.json({"message": "User tidak ditemukan"}, 404);
    }

    await User().query().where('id', '=', id).delete();

    return Response.json({"message": "User berhasil dihapus"});
  }
}

final UserController userController = UserController();
