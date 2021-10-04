class Records {
  final num id;
  final String nomeEquipUrbano;
  final String tipoEquipUrbano;
  final String enderecoEquipUrbano;
  final num codigoLogradouro;
  final String leiEquipUrbano;
  final String nomeOficialEquipUrbano;
  final String area;
  final String perimetro;
  final num codigoBairro;
  final String nomeBairro;
  final num latitude;
  final num longitude;
  final String image;

  Records(
      {required this.id,
      required this.nomeEquipUrbano,
      required this.tipoEquipUrbano,
      required this.enderecoEquipUrbano,
      required this.codigoLogradouro,
      required this.leiEquipUrbano,
      required this.nomeOficialEquipUrbano,
      required this.area,
      required this.perimetro,
      required this.codigoBairro,
      required this.nomeBairro,
      required this.latitude,
      required this.longitude,
      required this.image});

  Records.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'] ?? 0,
        nomeEquipUrbano =
            data['nome_equip_urbano'] ?? 'Nome Equipamento Urbano',
        tipoEquipUrbano =
            data['tipo_equip_urbano'] ?? 'Nome Equipamento Urbano',
        enderecoEquipUrbano =
            data['endereco_equip_urbano'] ?? 'Nome Equipamento Urbano',
        codigoLogradouro = data['codigo_logradouro'] ?? 0.0,
        leiEquipUrbano =
            data['lei_equip_urbano'] ?? 'Nome Equipamento Urbano',
        nomeOficialEquipUrbano =
            data['nome_oficial_equip_urbano'] ?? 'Nome Equipamento Urbano',
        area = data['area'] ?? 'Nome Equipamento Urbano',
        perimetro = data['perimetro'] ?? 'Nome Equipamento Urbano',
        codigoBairro = data['codigo_bairro'] ?? 0.0,
        nomeBairro = data['nome_bairro'] ?? 'Nome Equipamento Urbano',
        latitude = data['latitude'] ?? 0.0,
        longitude = data['longitude'] ?? 0.0,
        image = data['image'] ?? 'https://picsum.photos/200/300?grayscale';
}
