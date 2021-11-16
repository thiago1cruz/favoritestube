import 'package:favoritestube/blocs/favorite_bloc.dart';
import 'package:favoritestube/blocs/videos_bloc.dart';
import 'package:favoritestube/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => VideosBloc(),
        child: BlocProvider(
          create: (context) => FavoriteBloc(),
          child: const MaterialApp(
            title: 'FavoritesTube',
            home: Home(),
          ),
        ));
  }
}
