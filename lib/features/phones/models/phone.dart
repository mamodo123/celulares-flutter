class Phone {
  final int id;
  final String relEstabelecimentosId;
  final String relCategoriasId;
  final String destaque;
  final String ref;
  final String? codigoPdv;
  final int pontos;
  final int permitirTroca;
  final int pontosItem;
  final String nome;
  final String descricao;
  final String valor;
  final String oferta;
  final String valorPromocional;
  final String? variacao;
  final String visible;
  final String status;
  final DateTime created;
  final DateTime lastModified;
  final String statusp;
  final String integrado;
  final String? pesoFrete;
  final String? alturaFrete;
  final String? larguraFrete;
  final String? comprimentoFrete;
  final String? diametroFrete;
  final String estoque;
  final String posicao;
  final String categoria;
  final List<String> images;

  Phone({
    required this.id,
    required this.relEstabelecimentosId,
    required this.relCategoriasId,
    required this.destaque,
    required this.ref,
    this.codigoPdv,
    required this.pontos,
    required this.permitirTroca,
    required this.pontosItem,
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.oferta,
    required this.valorPromocional,
    this.variacao,
    required this.visible,
    required this.status,
    required this.created,
    required this.lastModified,
    required this.statusp,
    required this.integrado,
    this.pesoFrete,
    this.alturaFrete,
    this.larguraFrete,
    this.comprimentoFrete,
    this.diametroFrete,
    required this.estoque,
    required this.posicao,
    required this.categoria,
    required this.images,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      id: json['id'],
      relEstabelecimentosId: json['rel_estabelecimentos_id'],
      relCategoriasId: json['rel_categorias_id'],
      destaque: json['destaque'],
      ref: json['ref'],
      codigoPdv: json['codigo_pdv'],
      pontos: json['pontos'],
      permitirTroca: json['permitir_troca'],
      pontosItem: json['pontos_item'],
      nome: json['nome'],
      descricao: json['descricao'],
      valor: json['valor'],
      oferta: json['oferta'],
      valorPromocional: json['valor_promocional'],
      variacao: json['variacao'],
      visible: json['visible'],
      status: json['status'],
      created: DateTime.parse(json['created']),
      lastModified: DateTime.parse(json['last_modified']),
      statusp: json['statusp'],
      integrado: json['integrado'],
      pesoFrete: json['pesofrete'],
      alturaFrete: json['alturafrete'],
      larguraFrete: json['largurafrete'],
      comprimentoFrete: json['comprimentofrete'],
      diametroFrete: json['diametrofrete'],
      estoque: json['estoque'],
      posicao: json['posicao'],
      categoria: json['categoria'],
      images: List<String>.from(json['images']),
    );
  }
}
