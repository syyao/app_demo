import 'package:app_demo/recettePage.dart';
import 'package:flutter/material.dart';

import 'detail_recette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      initialRoute: '/',
      onGenerateRoute: (settings) => Routegenerator.generateRoute(settings),
      //  DetailRecette(
      //   recette: Recette(
      //       'pizza au fromage',
      //       'chef sydney',
      //       'https://recette.supertoinette.com/150121/m/pizza-mozzarella-tomates-et-champignons.jpg',
      //       'fair cuire dans une poele les lardons et les champignons',
      //       false,
      //       50),
      // ),
    );
  }
}

class Routegenerator {
// creer une nouvelle methode qui va nous permet dappeler sans extentier route genrator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => RecettePage());
      case '/recettedetail':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailRecette(recette: settings.arguments),
            transitionsBuilder:
                // slide transition
                (context, animation, secondaryAnimation, child) {
              // var begin = Offset(0.0, 1.0);
              // var end = Offset.zero;
              // var curve = Curves.ease;
              // var tween = Tween(begin: begin, end: end)
              //     .chain(CurveTween(curve: curve));
              // return SlideTransition(
              //   position: animation.drive(tween),
              //   child: child,
              // );
              // fadetransition
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('error'),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: Text('page not foud'),
                  ),
                ));
    }
  }
}
