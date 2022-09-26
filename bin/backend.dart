import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'dao/usuario_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  UsuarioDAO _usuarioDAO = UsuarioDAO(_di.get<DBConfiguration>());
  //print(await _usuarioDAO.findAll());
  //(await _usuarioDAO.findAll()).forEach(print);
  print(await _usuarioDAO.findOne(5));

  

  var cascadeHandler = Cascade()
    .add(_di.get<LoginApi>().getHandler())
    .add(_di.get<BlogApi>().getHandler(isSecurity: true))
    .handler;

  var handler = Pipeline()
  .addMiddleware(logRequests())
  .addMiddleware(MiddlewareInterception().middleware)
  .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
  
}
