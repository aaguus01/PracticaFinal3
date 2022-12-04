import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/now_popular_response.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier{//esta clase es la que nos ayuda a hacer las peticiones get
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '0113a8c155b7630cca62fcc178abe7a3';//parametros de nuestra api, este en concreto es la apikey
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];//listado de peliculas
  List<Movie> popularMovies = [];//listado de peliculas populares

  Map<int, List<Cast>> casting = {}; //mapeo de castings


  MoviesProvider(){
    this.getOnDisplayMovies();//cargamos las peticiones
    this.getPopular();
  }

  getOnDisplayMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page
    });

    final result = await http.get(url);//esperamos resultado

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);//lo parseamos

    onDisplayMovies = nowPlayingResponse.results;//guardamos solo el listado de las peliculas

    notifyListeners();
  }

  getPopular() async{
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page
    });

    final resultado = await http.get(url);

    final nowPlayingResponse = NowPopularResponse.fromJson(resultado.body);

    popularMovies = nowPlayingResponse.results;//guardamos solo el resultado de las pelis populares

    notifyListeners();
  }

  Future<List<Cast>>getCredits(int idMovie) async{//de la peli que nos pasan el id solicitamos una peticion para que nos devuelva el reparto.
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resultado = await http.get(url);

    final nowPlayingResponse = CreditsResponse.fromJson(resultado.body);

    casting[idMovie] = nowPlayingResponse.cast;//guardamos dentro del mapa con el id de la peli el casting
    
    return nowPlayingResponse.cast;//devolvemos el reparto
  }


}