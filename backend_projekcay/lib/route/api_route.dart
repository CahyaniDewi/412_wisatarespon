import 'package:backend_projekcay/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';
import 'package:backend_projekcay/app/http/controllers/auth_controller.dart';
import 'package:backend_projekcay/app/http/controllers/wisata_controller.dart';
import 'package:backend_projekcay/app/http/controllers/user_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    // Base prefix for API routes
    Router.basePrefix('api');

    // Authentication Routes (auth prefix should be used)
    Router.group(() {
      Router.post('/register', authController.register);
      Router.post('/login', authController.login);
    }, prefix: 'auth');

    // Endpoint to get logged-in user's data (requires authentication middleware)
    Router.get('/auth/me', authController.me)
        .middleware([AuthenticateMiddleware()]);

    // User Routes
    Router.post('/users/create', userController.create);
    Router.get('/users', userController.index);
    Router.get('/users/{id}', userController.show);
    Router.put('/users/{id}', userController.update);
    Router.delete('/users/{id}', userController.destroy);

    // Wisata Routes
    Router.post('/wisatas/create', wisataController.create);
    Router.get('/wisatas', wisataController.index);
    Router.get('/wisatas/{id}', wisataController.show);
    Router.put('/wisatas/{id}', wisataController.update);
    Router.delete('/wisatas/{id}', wisataController.destroy);
  }
}

final ApiRoute apiRoute = ApiRoute();
