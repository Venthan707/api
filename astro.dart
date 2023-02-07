import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/dataseries.dart';

class astro extends StatefulWidget {
  const astro({Key? key}) : super(key: key);

  @override
  State<astro> createState() => _astroState();
}

class _astroState extends State<astro> {
  List<wind10m> astroList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<wind10m>> fetchdata() async {
    var resp = await http.get(Uri.parse(
        'https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0'));
    var W = jsonDecode(resp.body)['dataseries'];

    (W as List).forEach((t){
      astroList.add(wind10m.frommap((t['wind10m'])));
    });

    return astroList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Astro',
                style: TextStyle(color: Colors.indigo),
              ),
              backgroundColor: Colors.orangeAccent,
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white70,
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<List<wind10m>>(
                future: fetchdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<wind10m> astroList =
                        snapshot.data as List<wind10m>;
                    return ListView.builder(
                        itemCount: astroList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                Text(astroList[index].direction.toString()),
                                SizedBox(width: 10,),
                                Text(astroList[index].speed.toString()),
                              ],
                            ),
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Text('error');
                  }
                  return Center(
                      child: Container(
                          height: 150,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          )));
                },
              ),
            )));
  }
}
