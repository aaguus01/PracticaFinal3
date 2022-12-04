import 'package:practica_final_2/models/models.dart';
/*
Clase generada debido a la necesidad de mapear los datos de la petición get.
*/
class NowPopularResponse {
    NowPopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;//hacemos una lista de películas
    int totalPages;
    int totalResults;

    factory NowPopularResponse.fromJson(String str) => NowPopularResponse.fromMap(json.decode(str));

    factory NowPopularResponse.fromMap(Map<String, dynamic> json) => NowPopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}