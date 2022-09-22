//import 'package:backend/backend.dart' as backend;

import 'dart:io';

import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';
import 'infra/security/secutity_service.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  SecurityService _securityService = SecurityServiceImp();

  var cascadeHandler = Cascade()
    .add(LoginApi(_securityService).getHandler())
    .add(BlogApi(NoticiaService()).getHandler(
      middlewares: [
        _securityService.authorizarion,
        _securityService.verifyJwt
      ],
    ))
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
