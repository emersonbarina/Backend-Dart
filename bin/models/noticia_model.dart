import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {

  final int id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtualizacao;

  NoticiaModel(
    this.id, 
    this.titulo, 
    this.descricao, 
    this.imagem, 
    this.dtPublicacao, 
    this.dtAtualizacao
  );

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtualizacao: $dtAtualizacao)';
  }

  /*Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'dtPublicacao': dtPublicacao.millisecondsSinceEpoch,
      'dtAtualizacao': dtAtualizacao?.millisecondsSinceEpoch,
    };
  }*/

  Map toJson() {
    return {
      
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'dtPublicacao': dtPublicacao.millisecondsSinceEpoch,
      'dtAtualizacao': dtAtualizacao?.millisecondsSinceEpoch,
    };
    
  }

  //String toJson() => json.encode(toMap());

  factory NoticiaModel.fromMap(Map<String, dynamic> map) {
    return NoticiaModel(
      (map['id'] ?? 0) as int,
      (map['titulo'] ?? '') as String,
      (map['descricao'] ?? '') as String,
      (map['imagem'] ?? '') as String,
      DateTime.fromMillisecondsSinceEpoch((map['dtPublicacao']??0) as int),
      map['dtAtualizacao'] != null ? DateTime.fromMillisecondsSinceEpoch((map['dtAtualizacao']??0) as int) : null,
    );
  }

  

  factory NoticiaModel.fromJson(String source) => NoticiaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
