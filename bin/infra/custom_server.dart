import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {

  Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    print('inicializando - > Handler: $handler address: $address port: $port ');
    await shelf_io.serve(handler, address, port);
    print('Servidor inicializado - > http://$address:$port');
  }
  //Future<void> initialize(Handler handler) async {
  //  String address = 'localhost';
  //  int port = 8080;
  //  await shelf_io.serve(handler, address, port);
  //  print('Servidor inicializado - > http://$address:$port');
  //}
}