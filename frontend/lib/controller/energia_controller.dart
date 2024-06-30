import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/energia_model.dart';

int numRequest = 0;
Future<Energia> fetchEnergiaTempoReal() async {
  numRequest++;
  final response = await http.get(Uri.parse("http://localhost:8080"));
  if (response.statusCode == 200) {
    return Energia.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Sem energia na request N°$numRequest');
  }
}

Future<List<Energia>> fetchEnergiaInicio() async {
  final response = await http.get(Uri.parse("http://localhost:8080/historico"));
  if (response.statusCode == 200) {
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Energia> energiaList =
        tagObjsJson.map((json) => Energia.fromJson(json)).toList();
    return energiaList;
  } else {
    throw Exception('Sem energia inicial');
  }
}
