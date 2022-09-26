typedef T InstanceCreator<T>();

class DependencyInjector {
  //DependencyInjector(); // Construtor
  DependencyInjector._(); // Contrutor Privado
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  // Mapa
  final _instanceMap = Map<Type, _InstanceGenerator<Object>>();
  
  // Register : Método para registrar nossa instância
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,   
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  // get : Pegar e devolver a nossa instância
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }

  call<T extends Object>() => get<T>();
}
class _InstanceGenerator<T> {

  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(this._instanceCreator, bool isSingleton) :_isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    //return _instance ?? _instanceCreator();
    return _instance != null ? _instance : _instanceCreator();
  }
}