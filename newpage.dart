import 'package:api/Model/biodata.dart';
import 'package:api/student.dart';
import 'package:flutter/material.dart';

class newpage extends StatefulWidget {
  final  biodata studentlist;
  const newpage(this.studentlist);



  @override
  State<newpage> createState() => _newpageState();
}

class _newpageState extends State<newpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Student Biodata',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.blueAccent.shade100,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text('ID',style: TextStyle(fontSize: 20),),
                      Text('NAME',style: TextStyle(fontSize: 20)),
                      Text("EMAIL",style: TextStyle(fontSize: 20)),
                      Text('GENDER',style: TextStyle(fontSize: 20)),
                      Text("STATUS",style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text(':',style: TextStyle(fontSize: 20)),
                      Text(':',style: TextStyle(fontSize: 20)),
                      Text(":",style: TextStyle(fontSize: 20)),
                      Text(':',style: TextStyle(fontSize: 20)),
                      Text(":",style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 250,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.studentlist.id.toString(),style: TextStyle(fontSize: 20)),
                        Text(widget.studentlist.name.toString(),style: TextStyle(fontSize: 20)),
                        Text(widget.studentlist.email.toString(),style: TextStyle(fontSize: 20)),
                        Text(widget.studentlist.gender.toString(),style: TextStyle(fontSize: 20)),
                        Text(widget.studentlist.status.toString(),style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
