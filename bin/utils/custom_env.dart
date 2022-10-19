import 'dart:io';
import 'parser_extension.dart';

class CustomEnv {
  static Map<String, String> _map = {};
  static String _file = '.env';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _load();
    return _map[key]!.toType(T);
  }

  static Future<void> _load() async {
    bool existFile = await File(_file).exists();
    if (existFile) {
      List<String> linhas = (await _readFile()).split('\n')
        ..removeWhere((e) => e.isEmpty);
      _map = {for (var l in linhas) l.split('=')[0]: l.split('=')[1]};
    } else {
      print('Arquivo de configurações não foi encontrado');
    }  
  }

  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}