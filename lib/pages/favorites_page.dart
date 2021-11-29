import 'package:favoritestube/api.dart';
import 'package:favoritestube/blocs/favorite_bloc.dart';
import 'package:favoritestube/models/video.dart';
import 'package:favoritestube/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
          initialData: {},
          stream: bloc.outFav,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.values
                    .map((video) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VideoPage(
                                        idVideo: video.id,
                                      ))),
                          onLongPress: () {
                            bloc.toggleFavorite(video: video);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: Image.network(video.thumb),
                              ),
                              Expanded(
                                child: Text(
                                  video.title,
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
