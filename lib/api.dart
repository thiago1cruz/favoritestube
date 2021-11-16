import 'package:dio/dio.dart';
import 'package:favoritestube/models/video.dart';

const API_KEY = '';

class Api {
  late String _search;
  late String _nextToken;

  Future<List<Video>> search({required String search}) async {
    _search = search;
    //busca videos no youtube através de uma string
    final response = await Dio().get(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10');

    return decode(response);
  }

  //paginação para continuar a sequencia dos videos
  Future<List<Video>> nextPage() async {
    final response = await Dio().get(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken');

    return decode(response);
  }

  List<Video> decode(Response response) {
    if (response.statusCode == 200) {
      var decoded = response.data;
      _nextToken = decoded['nextPageToken'];
      List<Video> videos =
          decoded['items'].map<Video>((e) => Video.fromJson(e)).toList();
      return videos;
    } else {
      throw Exception('Faild to Load videos');
    }
  }
}
