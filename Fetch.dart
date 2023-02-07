import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Employee.dart';

class FetchAPI extends StatefulWidget {
  const FetchAPI({Key? key}) : super(key: key);

  @override
  State<FetchAPI> createState() => _FetchAPIState();
}

class _FetchAPIState extends State<FetchAPI> {
  List<Album> album = [];

  @override
  void initState() {
    super.initState();
    print("init state");
    //fetchAlbum();
  }

  Future<List<Album>> fetchAlbum() async {
    final resp = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    album.add(Album.fromMap(json.decode(resp.body)));
    return album;


  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: FutureBuilder<List<Album>>(
      future: fetchAlbum(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: album.length,
            itemBuilder: (context, index) {
              return Text(album[index].title.toString());
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ));
  }
}
