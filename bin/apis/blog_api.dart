import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();

    // Listagem
    router.get('/blog/noticias', (Request req) {
      return Response.ok('Choveu hoje');
    });
    
    // Nova 
    router.post('/blog/noticias', (Request req) {
      return Response.ok('Choveu hoje');
    });

    // atualizar : /blog/noticias?id=1  // update
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });

    // excluir : /blog/noticias?id=1  // delete
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}