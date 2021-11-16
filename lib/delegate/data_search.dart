import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      );

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
          future: suggestions(query),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    leading: const Icon(Icons.play_arrow),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }
          });
    }
  }

  Future<List> suggestions(String search) async {
    //auto complete do google API Youtube, sugere palavras mais procuradas
    Response response = await Dio().get(
        'http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json');

    if (response.statusCode == 200) {
      return response.data[1].map((e) => e[0]).toList();
    } else {
      throw Exception('Faild to load suggestions');
    }
  }
}