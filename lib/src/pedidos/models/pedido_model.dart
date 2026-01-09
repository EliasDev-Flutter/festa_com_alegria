import 'dart:convert';

class PedidoModel {
  final String id;
  final String nomeCliente;
  final String tema;
  final String dataEntrega;
  final String tipoPedido;
  final String formaPagamento;
  final String descricao;
  final String valorTotal;

  PedidoModel({
    required this.id,
    required this.nomeCliente,
    required this.tema,
    required this.dataEntrega,
    required this.tipoPedido,
    required this.formaPagamento,
    required this.descricao,
    required this.valorTotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'tema': tema,
      'dataEntrega': dataEntrega,
      'tipoPedido': tipoPedido,
      'formaPagamento': formaPagamento,
      'descricao': descricao,
      'valorTotal': valorTotal,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'] ?? '',
      nomeCliente: map['nomeCliente'] ?? '',
      tema: map['tema'] ?? '',
      dataEntrega: map['dataEntrega'] ?? '',
      tipoPedido: map['tipoPedido'] ?? '',
      formaPagamento: map['formaPagamento'] ?? '',
      descricao: map['descricao'] ?? '',
      valorTotal: map['valorTotal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) => PedidoModel.fromMap(json.decode(source));
}
