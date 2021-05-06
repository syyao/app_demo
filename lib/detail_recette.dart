import 'package:app_demo/favoritechangenotifier.dart';
import 'package:app_demo/recette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favoriteTextWidget.dart';
import 'favoriteWidget.dart';

class DetailRecette extends StatelessWidget {
  final Recette recette;

  const DetailRecette({Key key, @required this.recette}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteChangeNotifier(recette),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Hero(
              tag: "imagerecette" + recette.title,
              child: FadeInImage.assetNetwork(
                height: 200,
                width: MediaQuery.of(context).size.width,
                placeholder: 'images/dft.jpg',
                image: recette.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recette.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            recette.user,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      FavoriteIconWidget(),
                      FavoriteTextWidget(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              padding: EdgeInsets.all(5),
                              icon: Icon(
                                Icons.messenger_outline,
                              ),
                              onPressed: () {}),
                          Text(
                            'commment',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.share,
                              ),
                              onPressed: () {}),
                          Text(
                            'share',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(recette.description),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
