
class ApiRouterValidate {
  
  //Tornando o construtor privado
  //ApiRouterValidate._(); 

  final List<String> _rotas = [];
  
  ApiRouterValidate add(String rota) {
    _rotas.add(rota);
    return this;
  }

  bool isPublic(String rota) {
    return _rotas.contains(rota);
  }
}