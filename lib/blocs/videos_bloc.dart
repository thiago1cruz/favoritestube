import 'dart:async';

import 'package:favoritestube/api.dart';
import 'package:favoritestube/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosBloc extends BlocBase {
  Api? api;
  late List<Video> videos;
  final _videosController = StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final _searchController = StreamController<String?>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() : super(null) {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String? search) async {
    if (search != null) {
      _videosController.sink.add([]);
      videos = await api!.search(search: search);
    } else {
      videos += await api!.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
