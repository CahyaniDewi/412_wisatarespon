import 'dart:io';
import 'package:backend_projekcay/app/models/user.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  // Register a new user
  Future<Response> register(Request request) async {
    // Validate input
    request.validate({
      'name': "required",
      'email': "required|email",
      "password": "required|min_length:6|confirmed",
    }, {
      'name.required': "Nama tidak boleh kosong",
      'email.required': "Email tidak boleh kosong",
      'email.email': 'Format email tidak valid',
      'password.required': "Password tidak boleh kosong",
      'password.min_length': "Password harus minimal 6 karakter",
      'password.confirmed': "Konfirmasi password tidak sesuai",
    });

    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password').toString();

    // Check if the email is already registered
    var user = await User().query().where('email', '=', email).first();
    if (user != null) {
      return Response.json({
        "message": "Email sudah terdaftar",
      }, 409);
    }

    // Hash the password and create the user
    password = Hash().make(password);
    await User().query().insert({
      "name": name,
      "email": email,
      "password": password,
      "created_at": DateTime.now().toIso8601String(),
    });

    return Response.json({"message": "Pendaftaran berhasil"}, 201);
  }

  // Login an existing user
  Future<Response> login(Request request) async {
    // Validate input
    request.validate({
      'email': 'required|email',
      'password': 'required',
    }, {
      'email.required': 'Email tidak boleh kosong',
      'email.email': 'Format email tidak valid',
      'password.required': 'Password tidak boleh kosong',
    });

    final email = request.input('email');
    var password = request.input('password').toString();

    // Find user by email
    var user = await User().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({
        "message": "Email belum terdaftar",
      }, 404);
    }

    // Verify password
    if (!Hash().verify(password, user['password'])) {
      return Response.json({
        "message": "Password yang dimasukkan salah",
      }, 401);
    }

    // Generate token
    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

    return Response.json({
      "message": "Login berhasil",
      "token": token,
    });
  }

  // Get current authenticated user
  Future<Response> me() async {
    // Get user from the Auth middleware
    Map? user = Auth().user();

    if (user != null) {
      user.remove('password'); // Remove password from the response
      return Response.json({
        'message': "Berhasil mendapatkan data",
        'data': user,
      }, HttpStatus.ok);
    }

    return Response.json({
      'message': "User tidak ditemukan",
      'data': null,
    }, HttpStatus.notFound);
  }
}

final AuthController authController = AuthController();
