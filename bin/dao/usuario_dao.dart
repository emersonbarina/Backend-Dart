import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UsuarioModel> {

  final DBConfiguration _dbConfiguration;
  // Invertendo o controle de Independencia
  UsuarioDAO(this._dbConfiguration);

  @override
  Future<List<UsuarioModel>> findAll() async {
    final String SQL = 
        'SELECT * FROM usuarios';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(SQL);
    List<UsuarioModel> _usuarios = [];
    for (var r in result) {
      _usuarios.add(UsuarioModel.fromMap(r.fields));
    }
    return _usuarios;
  }

  @override
  Future<UsuarioModel> findOne(int id) async {
    final String SQL = 
        'SELECT * FROM usuarios WHERE id = ?';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(SQL, [id]);
    if(result.length  <= 0) {
      throw Exception('[ERROR/DB] -> findOne for id: $id, Not Found.');
    }
    return UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future save(UsuarioModel value) async {
    final String SQL = 
        'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?);';
    var connection = await _dbConfiguration.connection;
    var result = 
        await connection.query(SQL, [value.name, value.email, value.password]);
    return result.affectedRows > 0;
  }

  @override
  Future update(UsuarioModel value) async {
    final String SQL = 
        'UPDATE usuarios set nome = ?, password = ? where id = ?;';
    var connection = await _dbConfiguration.connection;
    var result = 
        await connection.query(SQL, [value.name, value.password, value.id]);
    return result.affectedRows > 0;
  }

  @override
  Future delete(int id) async {
    final String SQL = 
        'DELETE from usuarios where id = ?;';
    var connection = await _dbConfiguration.connection;
    var result = 
        await connection.query(SQL, [id]);
    return result.affectedRows > 0;
  }
  
}