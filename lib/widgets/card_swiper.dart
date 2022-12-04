import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';

class CardSwiper extends StatelessWidget { 

  final List<Movie> movies;//hacemos una lista de las pelis que nos pasan

  const CardSwiper({
    Key? key, 
    required this.movies
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0)//hacemos un spinner hasta que tengamos la información
    {
      return Container(
        width: double.infinity,
        height: size.height*0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index){
          final movie = movies[index];
          return intento(context, movie);
        },
      )
    );
  }

  GestureDetector intento(BuildContext context, Movie movie) {
    return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),//enviamos la imagen si pulsan a detailsScreen
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterPath),//devolvemos la imagen
              fit: BoxFit.cover
             ),
          ),
        );
  }
}