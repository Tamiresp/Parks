class Parks {
  final List<Records> records;

  Parks(this.records);

  // Parks.fromJson(List<Records> json)
  //     : records = json['records'] as List<Records>;

  // Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
  //       'records': records,
  //       'text': text,
  //     };
}

class Records {
  final int _id;
  final String nome_equip_urbano;
  final String tipo_equip_urbano;
  final String endereco_equip_urbano;
  final int codigo_logradouro;
  final String lei_equip_urbano;
  final String nome_oficial_equip_urbano;
  final String area;
  final String perimetro;
  final int codigo_bairro;
  final int nome_bairro;
  final int latitude;
  final int longitude;
  final String tag;
  final String image;

  Records(
      this._id,
      this.nome_equip_urbano,
      this.tipo_equip_urbano,
      this.endereco_equip_urbano,
      this.codigo_logradouro,
      this.lei_equip_urbano,
      this.nome_oficial_equip_urbano,
      this.area,
      this.perimetro,
      this.codigo_bairro,
      this.nome_bairro,
      this.latitude,
      this.longitude,
      this.tag,
      this.image);
}
