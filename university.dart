import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'Model/country.dart';

class usity extends StatefulWidget {
  const usity({Key? key}) : super(key: key);

  @override
  State<usity> createState() => _usityState();
}

class _usityState extends State<usity> {
  List<universitty> universityList = [];
  late univesityDataGridSource datagrid;

  @override
  void initstate() {
    super.initState();
    print("init state");
  }

  Future fatchuniversity() async {
    var response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=United+States'));
    var list = jsonDecode(response.body).cast<Map<String, dynamic>>();
    universityList = await list
        .map<universitty>((json) => universitty.forMap(json))
        .toList();
    datagrid = univesityDataGridSource(universityList);
    return universityList;
  }

  List<GridColumn> getcolumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'Name',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'NAME',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'Alpha_Two_Code',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'ALPHA_TWO_CODE',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'Web_Pages',

          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'WEB_PAGES',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'State_Province',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'STATE_PROVINCE',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'Domains',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'DOMAINS',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          )),
      GridColumn(
          columnName: 'Country',
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(
              'COUNTRY',
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
            elevation: 2,
            backgroundColor: Colors.greenAccent.shade100,
            centerTitle: true,
            title: Text(
              "US universities",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: FutureBuilder(
            future: fatchuniversity(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? SfDataGrid(source: datagrid, columns: getcolumns())
                  : Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.greenAccent,
                      ),
                    );
            },
          )),
    );
  }
}

class univesityDataGridSource extends DataGridSource {
  univesityDataGridSource(this.universityList) {
    buildDataGridRow();
  }

  late List<DataGridRow> dataGridRows;
  late List<universitty> universityList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = universityList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: "Name", value: dataGridRow.name),
        DataGridCell(
            columnName: "Web_Pages", value: dataGridRow.alpha_two_code),
        DataGridCell(
            columnName: "Alpha_Two_Code", value: dataGridRow.web_pages),
        DataGridCell(
            columnName: "State_Province", value: dataGridRow.state_province),
        DataGridCell(columnName: "Domains", value: dataGridRow.domains),
        DataGridCell(columnName: "Country", value: dataGridRow.country),
      ]);
    }).toList(growable: false);
  }
}
