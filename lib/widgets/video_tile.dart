import 'package:favoritestube/blocs/favorite_bloc.dart';
import 'package:favoritestube/models/video.dart';
import 'package:favoritestube/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  const VideoTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => VideoPage(
                    idVideo: video.id,
                  ))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  initialData: {},
                  stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          onPressed: () {
                            BlocProvider.of<FavoriteBloc>(context)
                                .toggleFavorite(video: video);
                          },
                          icon: Icon(
                            snapshot.data!.containsKey(video.id)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white,
                            size: 30,
                          ));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
