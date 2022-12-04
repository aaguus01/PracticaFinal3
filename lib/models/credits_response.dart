import 'package:practica_final_2/models/models.dart';
/*
Clase que hemos creado desde quick type, los parametros que nos devuelve la api son los que se ven, quitamos uno porque no lo necesitabamos
*/
class CreditsResponse {
    CreditsResponse({
      required this.id,
      required this.cast,
    });

    int id;
    List<Cast> cast;//hacemos lista de los castings

    factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    );

}
