// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {

  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UsuarioModel(); 

  UsuarioModel.create(
    this.id, 
    this.name, 
    this.email, 
    this.isActived, 
    this.dtCreated, 
    this.dtUpdated
  );


factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel.create(
      (map['id'] ?? 0) as int,
      (map['nome'] ?? '') as String,
      (map['email'] ?? '') as String,
      (map['is_ativo'] == 1),
      //DateTime.fromMillisecondsSinceEpoch((map['dt_criacao']??0) as int),
      map['dt_criacao'],
      //DateTime.fromMillisecondsSinceEpoch((map['dt_atualizacao']??0) as int),
      map['dt_autalizacao'],
    );
  }


  @override
  String toString() {
    return 'UsuarioModel(id: $id, name: $name, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
  
}
