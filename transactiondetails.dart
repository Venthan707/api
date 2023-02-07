import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'Model/transaction.dart';

class transactiondetails extends StatefulWidget {
  const transactiondetails({Key? key}) : super(key: key);

  @override
  State<transactiondetails> createState() => _transactiondetailsState();
}

class _transactiondetailsState extends State<transactiondetails> {
  List<transaction> transactionlist = [];
  late transactiondatagridsource datagrid;
  TextEditingController txtTransaction = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<transaction>> fetchtransaction() async {
    var resp = await http.get(Uri.parse(
        'https://gtgym.elevadosoftwares.com/transactionmode/gettransactionmode'));
    setState((){
      transactionlist = (json.decode(resp.body)['transactionModeList'] as List)
          .map((t) => transaction.formap(t))
          .toList();
      datagrid = transactiondatagridsource(transactionlist);
    });


    return transactionlist;
  }

 void addTransaction() async {
   var resp = await http.post(
     Uri.parse('https://gtgym.elevadosoftwares.com/transactionmode/inserttransactionmode'),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(<String, String>{
       'transactionModeId': '0',
       'transactionModeName': txtTransaction.text,
       'createdBy': '1'
     }),
   );


    var data =jsonDecode(resp.body);
    if(data["success"])
      {
        print("Added new transaction");
      }
  }

  List<GridColumn> getcolumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'transactionModeId',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'transactionModeId',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'transactionModeName',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'transactionModeName',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'createdBy',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'createdBy',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'userName',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'userName',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          "TransactionMode",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: AlertDialog(
                          title: Text("TransactionMode"),
                          content: TextFormField(
                            controller: txtTransaction,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("cancel")),
                            TextButton(onPressed: () {
                              addTransaction();
                              Navigator.pop(context);
                              fetchtransaction();
                              txtTransaction.text = "";
                            }, child: Text("Submit"))
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: FutureBuilder(
        future: fetchtransaction(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGrid(source: datagrid, columns: getcolumns())
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      ),
    ));
  }
}

class transactiondatagridsource extends DataGridSource {
  transactiondatagridsource(this.transactionlist) {
    buildDataGridRow();
  }

  late List<DataGridRow> datagridrows;
  late List<transaction> transactionlist;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => datagridrows;

  void buildDataGridRow() {
    datagridrows = transactionlist.map<DataGridRow>((datagridrow) {
      return DataGridRow(cells: [
        DataGridCell(
            columnName: 'transactionModeId',
            value: datagridrow.transactionModeId.toString()),
        DataGridCell(
            columnName: 'transactionModeName',
            value: datagridrow.transactionModeName.toString()),
        DataGridCell(
            columnName: 'createdBy', value: datagridrow.createdBy.toString()),
        DataGridCell(
            columnName: 'userName', value: datagridrow.userName.toString()),
      ]);
    }).toList(growable: false);
  }
}
