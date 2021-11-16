import 'dart:convert';

import 'package:favoritestube/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  FavoriteBloc() : super(null) {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        _favorites = jsonDecode(prefs.getString('favorites').toString())
            .map((k, v) => MapEntry(k, Video.fromJson(v)))
            .cast<String, Video>();

        _favController.add(_favorites);
      }
    });
  }

  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  void toggleFavorite({required Video video}) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((pref) {
      pref.setString('favorites', jsonEncode(_favorites));
    });
  }
}
