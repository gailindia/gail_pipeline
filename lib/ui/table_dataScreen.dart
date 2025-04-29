import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';

// // Beautify function
// String beautifyHeader(String text) {
//   return text.replaceAll('_', ' ').split(' ').map((word) =>
//       word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : ''
//   ).join(' ');
// }

//////////////////////////// header data //////////////////////////////////////
final headersMap = {
  "COMP": ['Name', 'SP\n(Kg/cm2)', 'DP\n(Kg/cm2)', 'FR\n(KSCMH)'],
  "INJT": ['Name', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "GPU": [
    'GAS\nPLANT',
    'PR\n(Kg/cm2)',
    'VOL\n(KSCMH)',
    'C2/C4\n(%)',
    'LOAD\n(%)',
  ],
  "EPP": ['Name', 'Region', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "CSCP": ['Name', 'Pressure\n(Kg/cm2)', 'Flow\n(KSCMH)'],
  "GASQ": ['Plant', 'C2\n(%)', 'C3\n(%)', 'C4\n(%)'],
  "LPK": ['Name', 'Region', 'Vol\n(MMSCM)'],
  "RMXN": ['Name', 'Region', 'FLow\n(KSCMH)'],
};
/////////////////////////// row data /////////////////////////////////////
final rowMap = {
  "COMP": ['name', 'Inlet', 'Discharg', 'Flow'],
  "INJT": ['name', 'Inlet', 'Flow'],
  "GPU": [
    'name',
    'FedGas_PR',
    'FedGas_Volume',
    'FedGas_C_Four',
    'Plant_Load_Percentage',
  ],
  "EPP": ['name', 'Parameter_Code', 'FedGas_Volume', 'FedGas_PR'],
  "CSCP": ['name', 'Inlet', 'Flow'],
  "GASQ": ['name', 'FedGas_PR', 'FedGas_Volume', 'FedGas_C_Four'],
  "LPK": ['name', 'Parameter_Code', 'FedGas_PR'],
  "RMXN": ['name', 'Parameter_Code', 'FedGas_PR'],
};

class GasTableData extends StatefulWidget {
  final List<Map<String, dynamic>> gasTableData;
  final String type;

  const GasTableData({
    required this.gasTableData,
    required this.type,
    super.key,
  });

  @override
  State<GasTableData> createState() => _GasTableDataState();
}

class _GasTableDataState extends State<GasTableData> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gasTableData.isEmpty) {
      return const Center(child: Text("No Data Available"));
    }

    final gasDataSource = _GasDataSource(
      widget.gasTableData,
      widget.type,
      context,
    );

    final columns = gasDataSource.getColumns((columnIndex, ascending) {});

    if (columns.isEmpty) {
      return const Center(child: Text("No columns to display"));
    }
    final isPaginated = widget.gasTableData.length > 5;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
        child: DataTableTheme(
           data: DataTableThemeData(
    headingRowColor: WidgetStateProperty.all(Colors.blueAccent),
    dataRowColor: WidgetStateProperty.all(Colors.black),
    dividerThickness: 1,
  ),
          child: isPaginated
          ? PaginatedDataTable( 
            rowsPerPage: 10,
            columnSpacing: 20, 
            showCheckboxColumn: false,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: gasDataSource.getColumns((columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                gasDataSource.sort(columnIndex, ascending);
              });
            }),
            source: gasDataSource,
          )
          : DataTable(
            showCheckboxColumn: false,
              columns: columns,
              rows: List.generate(widget.gasTableData.length, (index) {
                final item = widget.gasTableData[index];
                return DataRow(
                  cells: gasDataSource.getRowCells(item),
                  onSelectChanged: (selected) {
                    if (selected ?? false) {
                      print('Row clicked: ${item['name']}');
                    }
                  },
                );
              }),
            ),
        ),
      ),
    );
  }
}

class _GasDataSource extends DataTableSource {
  final BuildContext context;
  List<Map<String, dynamic>> gasTableData;
  final String type;

  _GasDataSource(this.gasTableData, this.type, this.context);

  @override
  DataRow getRow(int index) {
    final item = gasTableData[index];

    return DataRow.byIndex(
      index: index,
      cells: getRowCells(item),
      onSelectChanged: (selected) {
        if (selected ?? false) {
          
          print('Row clicked: ${item['name']}');
        }
      },
    );
  }

  List<DataCell> getRowCells(Map<String, dynamic> item) {
    final fieldKeys = rowMap[type];

    // If type is not mapped, fallback to empty or all keys (as needed)
    if (fieldKeys != null) {
      return fieldKeys.map((key) {
        final value = item[key];
        return DataCell(Text(value?.toString() ?? '', style: txtStyleWhite));
      }).toList();
    } else {
      return item.values.map((value) {
        // log("item**** ${item['name']}  &&&& ${item['Region']}");
        return DataCell(Text(value?.toString() ?? ''));
      }).toList();
    }
  }

  List<DataColumn> getColumns(void Function(int, bool) onSortCallback) {
    final fields = headersMap[type];

    if (fields != null) {
      return List.generate(fields.length, (index) {
        return DataColumn(
          label: Text(fields[index]),
          onSort:
              (columnIndex, ascending) =>
                  onSortCallback(columnIndex, ascending),
        );
      });
    } else {
      if (gasTableData.isEmpty) {
        return [];
      }

      return gasTableData.first.keys.map((key) {
        return DataColumn(
          label: Text(key),
          onSort:
              (columnIndex, ascending) =>
                  onSortCallback(columnIndex, ascending),
        );
      }).toList();
    }
  }

  void sort(int columnIndex, bool ascending) {
    if (type == "COMP") {
      final fields = ['name', 'sp', 'dp', 'fr'];
      gasTableData.sort((a, b) {
        final aValue = a[fields[columnIndex]];
        final bValue = b[fields[columnIndex]];
        return ascending
            ? aValue.toString().compareTo(bValue.toString())
            : bValue.toString().compareTo(aValue.toString());
      });
    } else {
      final keys = gasTableData.first.keys.toList();
      gasTableData.sort((a, b) {
        final aValue = a[keys[columnIndex]];
        final bValue = b[keys[columnIndex]];
        return ascending
            ? aValue.toString().compareTo(bValue.toString())
            : bValue.toString().compareTo(aValue.toString());
      });
    }
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => gasTableData.length;
  @override
  int get selectedRowCount => 0;
}
