import 'package:app_demo/recette.dart';
import 'package:app_demo/recette_dataBase.dart';
import 'package:flutter/foundation.dart';

class FavoriteChangeNotifier with ChangeNotifier {
  Recette recette;

  FavoriteChangeNotifier(this.recette);

  bool get isFavorited => recette.isfavorite;

  int get favoriteCount => recette.favoriteCount + (recette.isfavorite ? 1 : 0);

  set isFavorited(bool isFavorited) {
    recette.isfavorite = isFavorited;
    //modifier une valeur dans la base de donnee
    RecetteDataBase.instance.updateRecipe(recette);
    notifyListeners();
  }
}
