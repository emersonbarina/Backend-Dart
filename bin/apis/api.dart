import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependecy_injector.dart';
import '../infra/security/secutity_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares, 
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    //final _di = DependencyInjector();
    //var _securityService = _di.get<SecurityService>();
    middlewares ??= []; // verifica se é nulo e atribui um list vazia

    if (isSecurity) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }
    var pipe = Pipeline();

    for (var m in middlewares) {
      pipe = pipe.addMiddleware(m);
    }

    return pipe.addHandler(router);
  }
}