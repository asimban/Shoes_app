import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void addToFavorites(String itemId) {
    if (!_favorites.contains(itemId)) {
      _favorites.add(itemId);
      notifyListeners();
    }
  }

  void removeFromFavorites(String itemId) {
    _favorites.remove(itemId);
    notifyListeners();
  }

  bool isFavorite(String itemId) {
    return _favorites.contains(itemId);
  }
}
