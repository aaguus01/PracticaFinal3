import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:practica_final_2/models/models.dart';


class CastingCards extends StatelessWidget {

  final int idMovie;
  const CastingCards({Key? key, required this.idMovie}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);
    
    return FutureBuilder(//hacemos un future del id que nos llegará
      future: moviesProvider.getCredits(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData)
        {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final casting = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: casting.length,//le ponemos el tamaño porque si es menos de 10 se sale y da error
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _CastCard(casting[index])
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  Cast casting;
  _CastCard(Cast this.casting);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(casting.fullProfilePath),//la imagen de la personas
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            casting.name,//el nombre del artista
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}