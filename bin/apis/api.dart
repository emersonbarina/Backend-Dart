import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependecy_injector.dart';
import '../infra/security/secutity_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,

  }) {
    final _di = DependencyInjector();

    var _securityService = _di.get<SecurityService>();
  
    middlewares ??= []; // verifica se é nulo e atribui um list vazia
    var pipe = Pipeline();

    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(router);
  }
}