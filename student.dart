import 'dart:convert';
import 'package:api/newpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/biodata.dart';

class student extends StatefulWidget {
  const student({Key? key}) : super(key: key);


  @override
  State<student> createState() => _studentState();
}

class _studentState extends State<student> {
  List<biodata> studentlist = [];

  @override
  void initstate() {
    super.initState();
    print('init state');
  }

  Future<List<biodata>> fetcbiodata() async {
    var resp =
        await http.get(Uri.parse('https://gorest.co.in/public/v1/users'));
    return (json.decode(resp.body)['data'] as List)
        .map((v) => biodata.forMap(v))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            centerTitle: true,
            title: const Text('Bio Data'),
          ),
          body:
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white70,
            padding: const EdgeInsets.all(8),
            child: FutureBuilder<List<biodata>>(
              future: fetcbiodata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<biodata> studentlist = snapshot.data as List<biodata>;
                  return ListView.builder(
                      itemCount: studentlist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // print(studentlist[index]);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>newpage(
                                 studentlist[index]
                              )));
                              // showModalBottomSheet(
                              //     context: context,
                              //     builder: (context) => SingleChildScrollView(
                              //           controller:
                              //               ModalScrollController.of(context),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Container(
                              //               height: 200,
                              //               child: Column(
                              //                 children: [
                              //                   Row(
                              //                     children: [
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           Text('ID'),
                              //                           Text('NAME'),
                              //                           Text("EMAIL"),
                              //                           Text('GENDER'),
                              //                           Text("STATUS"),
                              //                         ],
                              //                       ),
                              //                       SizedBox(
                              //                         width: 5,
                              //                       ),
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           Text(':'),
                              //                           Text(':'),
                              //                           Text(":"),
                              //                           Text(':'),
                              //                           Text(":"),
                              //                         ],
                              //                       ),
                              //                       SizedBox(
                              //                         width: 5,
                              //                       ),
                              //                       Container(
                              //                         width: 240,
                              //                         child: Column(
                              //                           crossAxisAlignment:
                              //                               CrossAxisAlignment
                              //                                   .start,
                              //                           children: [
                              //                             Text(
                              //                               studentlist[index]
                              //                                   .id
                              //                                   .toString(),
                              //                               style: TextStyle(
                              //                                   color: Colors
                              //                                       .blueAccent),
                              //                             ),
                              //                             Text(
                              //                                 studentlist[index]
                              //                                     .name
                              //                                     .toString()),
                              //                             Text(
                              //                               studentlist[index]
                              //                                   .email
                              //                                   .toString(),
                              //                               style: TextStyle(
                              //                                   color: Colors
                              //                                       .blueAccent),
                              //                             ),
                              //                             Text(
                              //                                 studentlist[index]
                              //                                     .gender
                              //                                     .toString()),
                              //                             Text(
                              //                                 studentlist[index]
                              //                                     .status
                              //                                     .toString()),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            color: Colors.grey.shade200,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ID'),
                                    Text('NAME'),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(':'),
                                    Text(':'),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 240,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        studentlist[index].id.toString(),
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                      Text(studentlist[index].name.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
          )),
    );
  }
}
