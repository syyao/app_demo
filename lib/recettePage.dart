import 'package:app_demo/recette_dataBase.dart';
import 'package:flutter/material.dart';
import 'recette.dart';

class RecettePage extends StatefulWidget {
  final Recette recette;

  const RecettePage({Key key, this.recette}) : super(key: key);
  @override
  _RecettePageState createState() => _RecettePageState();
}

class _RecettePageState extends State<RecettePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes recettes"),
      ),
      body: FutureBuilder<List<Recette>>(
          // futureBuider permet de faire de recette en background

          //  appelle la liste de recette dans recipedatabase
          // snapshot c'est le resultat de la liste de recette
          future: RecetteDataBase.instance.recetteList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Recette>> snapshot) {
            if (snapshot.hasData) {
              List<Recette> recetteList = snapshot.data;
              return ListView.builder(
                itemCount: recetteList.length,
                itemBuilder: (context, index) {
                  final recette = recetteList[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        RecetteDataBase.instance.deleteRecipe(recette.title);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${recette.title} suprimé")));
                    },
                    key: UniqueKey(),
                    child: RecetteItem(recette: recette),
                    background: Container(color: Colors.red),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class RecetteItem extends StatelessWidget {
  final Recette recette;

  const RecetteItem({Key key, this.recette}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/recettedetail', arguments: recette
            // context,
            // // MaterialPageRoute(
            // //     builder: (context) => DetailRecette(recette: recette))
            // PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         DetailRecette(recette: recette),
            //     transitionsBuilder:
            //         // slide transition
            //         (context, animation, secondaryAnimation, child) {
            //       // var begin = Offset(0.0, 1.0);
            //       // var end = Offset.zero;
            //       // var curve = Curves.ease;
            //       // var tween = Tween(begin: begin, end: end)
            //       //     .chain(CurveTween(curve: curve));
            //       // return SlideTransition(
            //       //   position: animation.drive(tween),
            //       //   child: child,
            //       // );
            //       // fadetransition
            //       animation =
            //           CurvedAnimation(parent: animation, curve: Curves.ease);
            //       return FadeTransition(
            //         opacity: animation,
            //         child: child,
            //       );
            //     }));
            );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Hero(
              tag: "imagerecette" + recette.title,
              child: FadeInImage.assetNetwork(
                height: 50,
                width: 50,
                placeholder: 'images/dft.jpg',
                image: recette.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recette.title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  recette.user,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
