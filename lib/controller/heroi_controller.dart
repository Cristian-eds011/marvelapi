import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvelapi/controller/http_controller.dart';
import 'package:marvelapi/models/heroi.dart';
import 'package:http/http.dart' as http;

class HeroiController extends ChangeNotifier {
  HeroiController() {
    _httpController = HttpController();
  }

  List<Heroi> listaHerois = [];
  bool _carregando = false;
  late HttpController _httpController;

  void alterarStatusCarregar() {
    _carregando = !_carregando;
    notifyListeners();
  }

  Future<List<Heroi>> buscarHerois() async {
    alterarStatusCarregar();
    final uri = Uri.parse(_httpController.getUrlFinal());
    final responseHerois = await http.get(uri);
    List<dynamic> responseMapHerois =
        jsonDecode(responseHerois.body)['data']['results'];
    List<Heroi> listaHerois =
        responseMapHerois.map<Heroi>((e) => Heroi.fromJson(e)).toList();
    populaListaHerois(listaHerois);
    
    return listaHerois;
  }

  Future<List<Heroi>> buscarHeroisPesquisa(String nomePesquisado) async {
    alterarStatusCarregar();
    final uri = Uri.parse(_httpController.getUrlFinalPesquisa(nomePesquisado));
    final responseHerois = await http.get(uri);
    List<dynamic> responseMapHerois =
        jsonDecode(responseHerois.body)['data']['results'];
    List<Heroi> listaHerois =
        responseMapHerois.map<Heroi>((e) => Heroi.fromJson(e)).toList();
    populaListaHerois(listaHerois);
    
    return listaHerois;
  }

  void populaListaHerois(List<Heroi> listFrom) {
    for (var heroiList in listFrom) {
      if (!heroiList.thumbnail.path.contains('image_not_available')) {
        listaHerois.add(heroiList);
      }
    }
    alterarStatusCarregar();
  }

  void zerarLista() {
    listaHerois = [];
    notifyListeners();
  }

  get carregando => _carregando;
}
