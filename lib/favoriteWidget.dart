import 'package:app_demo/favoritechangenotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  @override
  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  bool _isfavorite;

  void _toggleFavorite(FavoriteChangeNotifier _notifier) {
    setState(() {
      if (_isfavorite) {
        _isfavorite = false;
      } else {
        _isfavorite = true;
      }

      _notifier.isFavorited = _isfavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    FavoriteChangeNotifier _notifier =
        Provider.of<FavoriteChangeNotifier>(context);
    _isfavorite = _notifier.isFavorited;
    return IconButton(
        icon: Icon(_isfavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red),
        onPressed: () => _toggleFavorite(_notifier));
  }
}
