import 'package:favoritestube/blocs/favorite_bloc.dart';
import 'package:favoritestube/blocs/videos_bloc.dart';
import 'package:favoritestube/delegate/data_search.dart';
import 'package:favoritestube/models/video.dart';
import 'package:favoritestube/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('assets/img/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Text(snapshot.data!.length.toString());
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            snapshot.data!;
            return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data!.length) {
                    return VideoTile(video: snapshot.data![index]);
                  } else if (index > 1) {
                    BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          }
        },
      ),
    );
  }
}
