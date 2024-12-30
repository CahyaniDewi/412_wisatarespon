import 'package:vania/vania.dart';
import 'package:backend_projekcay/route/api_route.dart';
import 'package:backend_projekcay/route/web.dart';
import 'package:backend_projekcay/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
