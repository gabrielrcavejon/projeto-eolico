class Energia {
  double? volts;
  int? segundos;
  bool flagLigado;

  Energia({
    this.segundos,
    this.volts,
    required this.flagLigado,
  });

  factory Energia.fromJson(Map<String, dynamic> json) {
    return Energia(
      volts: json['volts'],
      flagLigado: (json['flagligado'] == "T") ? true : false,
    );
  }
}
