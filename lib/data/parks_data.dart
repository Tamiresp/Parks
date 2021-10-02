class Records {
  final int id;
  final String nome_equip_urbano;
  final String tipo_equip_urbano;
  final String endereco_equip_urbano;
  final double codigo_logradouro;
  final String lei_equip_urbano;
  final String nome_oficial_equip_urbano;
  final String area;
  final String perimetro;
  final double codigo_bairro;
  final String nome_bairro;
  final double latitude;
  final double longitude;

  Records(
      {required this.id,
      required this.nome_equip_urbano,
      required this.tipo_equip_urbano,
      required this.endereco_equip_urbano,
      required this.codigo_logradouro,
      required this.lei_equip_urbano,
      required this.nome_oficial_equip_urbano,
      required this.area,
      required this.perimetro,
      required this.codigo_bairro,
      required this.nome_bairro,
      required this.latitude,
      required this.longitude});

  factory Records.fromRTDB(Map<String, dynamic> data) {
    return Records(
        id: data['id'] ?? 0,
        nome_equip_urbano:
            data['nome_equip_urbano'] ?? 'Nome Equipamento Urbano',
        tipo_equip_urbano:
            data['tipo_equip_urbano'] ?? 'Nome Equipamento Urbano',
        endereco_equip_urbano:
            data['endereco_equip_urbano'] ?? 'Nome Equipamento Urbano',
        codigo_logradouro: data['codigo_logradouro'] ?? 0,
        lei_equip_urbano: data['lei_equip_urbano'] ?? 'Nome Equipamento Urbano',
        nome_oficial_equip_urbano:
            data['nome_oficial_equip_urbano'] ?? 'Nome Equipamento Urbano',
        area: data['area'] ?? 'Nome Equipamento Urbano',
        perimetro: data['perimetro'] ?? 'Nome Equipamento Urbano',
        codigo_bairro: data['codigo_bairro'] ?? 0,
        nome_bairro: data['nome_bairro'] ?? 'Nome Equipamento Urbano',
        latitude: data['latitude'] ?? 0,
        longitude: data['longitude'] ?? 0);
  }
}
