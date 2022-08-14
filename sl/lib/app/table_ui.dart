import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class TableUI extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const TableUI({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: DataSinkXDataSource(DataSinkXData: data),
        columnWidthMode: ColumnWidthMode.fill,
        columns: data[0]
            .keys
            .map<GridColumn>(
              (e) => GridColumn(
                columnName: e,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    e,
                  ),
                ),
              ),
            )
            .toList());
  }
}

class DataSinkX {
  /// Creates the DataSinkX class with required details.
  DataSinkX(this.id);

  /// Id of an DataSinkX.
  final int id;
}

class DataSinkXDataSource extends DataGridSource {
  // ignore: non_constant_identifier_names
  DataSinkXDataSource({required List<Map<String, dynamic>> DataSinkXData}) {
    _DataSinkXData = DataSinkXData.map<DataGridRow>(
      (e) {
        return DataGridRow(
          cells: e.keys
              .map((x) => DataGridCell(columnName: x, value: e[x]))
              .toList(),
        );
      },
    ).toList();
  }

  // ignore: non_constant_identifier_names
  List<DataGridRow> _DataSinkXData = [];

  @override
  List<DataGridRow> get rows => _DataSinkXData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: e.value.runtimeType == int
            ? Alignment.center
            : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(e.value.toString().trim()),
      );
    }).toList());
  }
}
