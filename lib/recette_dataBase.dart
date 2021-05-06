import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'recette.dart';

class RecetteDataBase {
  // creer un constructeur privé un singleton
  RecetteDataBase._();
  // creation de l'instance
  static final RecetteDataBase instance = RecetteDataBase._();
  // creation de base de donnee
  static Database _database;
// instancier la database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

// creation de la methode initbd pour initialiser la base de donnee
  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), ' Recette_database.db'),
      onCreate: (db, version) {
        return db.execute(
          // creation de classe
          "CREATE TABLE recette(title TEXT PRIMARY KEY, user TEXT, imageUrl TEXT, description TEXT, isfavorite INTEGER, favoriteCount INTEGER)",
        );
      },
      version: 1,
    );
  }

// insertion dans la base de donnee
  void insertRecipe(Recette recette) async {
    final Database db = await database;
// insertion dans la table recette
    await db.insert(
      'recette',
      recette.toMap(),
      // si la recette existe deja remplacer
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// modifier une valeur dans la base de donnee
  void updateRecipe(Recette recette) async {
    final Database db = await database;
    // cle primaire
    await db.update("recette", recette.toMap(),
        where: "title = ?", whereArgs: [recette.title]);
  }

// suprimer une recette dans ma base de donnee
  void deleteRecipe(String title) async {
    final Database db = await database;
    db.delete("recette", where: "title = ?", whereArgs: [title]);
  }

// methode pour recuperer la liste de recette dans ma base de donnée
  Future<List<Recette>> recetteList() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recette');
    List<Recette> recetteList = List.generate(maps.length, (i) {
      return Recette.fromMap(maps[i]);
    });

    if (recetteList.isEmpty) {
      for (Recette recette in defaultRecipes) {
        insertRecipe(recette);
      }
      recetteList = defaultRecipes;
    }

    return recetteList;
  }

  final List<Recette> defaultRecipes = [
    Recette(
        "Pizza facile",
        "Par David Silvera",
        "https://assets.afcdn.com/recipe/20160519/15342_w600.jpg",
        "Faire cuire dans une poêle les lardons et les champignons.\n\nDans un bol, verser la boîte de concentré de tomate, y ajouter un demi verre d'eau, ensuite mettre un carré de sucre (pour enlever l'acidité de la tomate) une pincée de sel, de poivre, et une pincée d'herbe de Provence.\n\nDérouler la pâte à pizza sur le lèche frite de votre four, piquer-le.\n\nAvec une cuillère à soupe, étaler délicatement la sauce tomate, ensuite y ajouter les lardons et les champignons bien dorer. Parsemer de fromage râpée.\n\nMettre au four à 220°, thermostat 7-8, pendant 20 min (ou lorsque le dessus de la pizza est doré).Faire cuire dans une poêle les lardons et les champignons.\n\nDans un bol, verser la boîte de concentré de tomate, y ajouter un demi verre d'eau, ensuite mettre un carré de sucre (pour enlever l'acidité de la tomate) une pincée de sel, de poivre, et une pincée d'herbe de Provence.\n\nDérouler la pâte à pizza sur le lèche frite de votre four, piquer-le.\n\nAvec une cuillère à soupe, étaler délicatement la sauce tomate, ensuite y ajouter les lardons et les champignons bien dorer. Parsemer de fromage râpée.\n\nMettre au four à 220°, thermostat 7-8, pendant 20 min (ou lorsque le dessus de la pizza est doré).",
        false,
        50),
    Recette(
        "Burger maison",
        "Par Cyril Lignac",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F03ab5e89-bad7-4a44-b952-b30c68934215.2Ejpeg/748x372/quality/90/crop-from/center/burger-maison.jpeg",
        "Pelez l’oignon rouge puis émincez-le. Rincez et essorez la roquette. Rincez la tomate puis coupez-la en rondelles.\nFaites chauffer l’huile dans une poêle et faites cuire les steaks 3 à 4 min de chaque côté, selon votre goût. En fin de cuisson, salez, poivrez, disposez 1 tranche de cheddar sur chaque steak et laissez-la légèrement fondre.\nFendez les petits pains en 2 et toastez-les légèrement. Montez les burgers : tartinez chaque moitié de pain de sauce puis garnissez avec la viande, les rondelles de tomate, l’oignon ciselé et les feuilles de roquette. Refermez les burgers et servez aussitôt.",
        true,
        33),
    Recette(
        "Crêpe comme chez nous",
        "Par Xouxou",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F830851b1-1f2a-4871-8676-6c06b0962938.2Ejpeg/748x372/quality/90/crop-from/center/crepes-comme-chez-nous.jpeg",
        "Versez la farine dans un grand saladier, creusez un puits. Cassez les œufs, délayez petit à petit avec le lait sans former de grumeaux. Ajoutez l’huile et le sel et mélangez bien.\nLaissez reposer la pâte 1 h sous un torchon propre à température ambiante.\nHuilez légèrement une poêle à crêpes, versez une demi-louche de pâte dans la poêle bien chaude, laissez cuire jusqu’à ce que les bords se détachent (30 sec environ). Retournez la crêpe, faites cuire l’autre face et glissez-la sur une assiette.\nProcédez ainsi pour toutes les crêpes.",
        true,
        13),
    Recette(
        "Cake nature sucré",
        "Par Huguette",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2FCAC.2Fvar.2Fcui.2Fstorage.2Fimages.2Fdossiers-gourmands.2Ftendance-cuisine.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama-187414.2F1637287-1-fre-FR.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama.2Ejpg/748x372/quality/90/crop-from/center/cake-nature-sucre.jpeg",
        "Travaillez le beurre avec le sucre en poudre.\nIncorporez les œufs, 1 par 1. Ajoutez la farine.\nVersez dans un moule à empreinte rectangulaire en silicone. Faites cuire 45 à 50 min dans le four, préchauffé à 180°C (th. 6).\nDémoulez et laissez refroidir avant de déguster.",
        true,
        18),
    Recette(
        "Donuts avec appareil à donuts",
        "Par Heud",
        "https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F80586d11-1f17-40ad-80ae-4cd9b5c42182.2Ejpeg/748x372/quality/90/crop-from/center/donuts-avec-appareil-a-donuts.jpeg",
        "Délayez la levure dans 2 cuil. à soupe de lait tiède. Réservez 15 min. Fouettez les œufs avec les sucres. Mélangez avec la farine et la levure. Incorporez le lait.\nLaissez la pâte reposer 1 h.\nFaites chauffer la machine et huilez les alvéoles avec un pinceau de cuisine. Versez des cuillerées de pâte dans les alvéoles de la machine chaude, en évitant de mettre de la pâte au centre. Faites cuire 2 min environ.\nFaites fondre le chocolat. Détendez-le avec un peu d'eau. Trempez-les beignets dans le chocolat. Parsemez de vermicelles. Laissez refroidir avant de déguster.",
        true,
        109),
    Recette(
        "Oreilles d'aman",
        "Par Esther",
        "https://2.bp.blogspot.com/-D9fvvQ1XyZk/WL7KSRDBe_I/AAAAAAAAhjI/udiioVWKJ20FV-P3WfW4V8TNXZDkQJ5bgCLcB/s1600/UNADJUSTEDNONRAW_thumb_3e0d.jpg",
        "Dans un saladier, battre l'œuf avec le sucre et le sucre vanillé.\nAjouter la farine et la levure et incorporer à la spatule.\nAjouter les morceaux de beurre et sabler avec les doigts comme quand on égraine la semoule.\nMalaxer ensuite avec les mains pour obtenir une boule.\nLaisser reposer 1h au frigo.",
        true,
        55)
  ];
}
