import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favoritechangenotifier.dart';

class FavoriteTextWidget extends StatefulWidget {
  @override
  _FavoriteTextWidgetState createState() => _FavoriteTextWidgetState();
}

class _FavoriteTextWidgetState extends State<FavoriteTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteChangeNotifier>(
        builder: (context, notifier, _) => Row(
              children: [
                Text(notifier.favoriteCount.toString()),
              ],
            ));
  }
}
