import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/ui/mapType.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';



class GasTableData extends StatefulWidget {
  final List<Map<String, dynamic>> gasTableData;
  final List <Map<String,dynamic>> getGasData;
  final String type;
  final void Function(Map<String, dynamic>)? onRowSelected;

  const GasTableData({
    required this.gasTableData,
    required this.getGasData,
    required this.type,this.onRowSelected,
    super.key,
  });

  @override
  State<GasTableData> createState() => _GasTableDataState();
}

class _GasTableDataState extends State<GasTableData> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

   

  @override
  Widget build(BuildContext context) {
 
    final gasDataSource = _GasDataSource(
      widget.gasTableData,
      widget.getGasData,
      widget.type,
      context,
    );

    final columns = gasDataSource.getColumns((columnIndex, ascending) {});

    if (columns.isEmpty) {
      return const Center(child: Text("No columns to display"));
    }
    final isPaginated = widget.gasTableData.length > 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final fieldKeys = rowMap[widget.type];
        final filteredRows =
            widget.gasTableData.where((item) {
              if (fieldKeys == null) return false;
              return fieldKeys.every((key) {
                final value = item[key];
                return value != null && value.toString().trim().isNotEmpty;
              });
            }).toList();
        final filteredGasTable = widget.getGasData.where((element) {
            final type = element['TYPE']?.toString().trim();
            return type == widget.type.toString().trim();
          }).toList();
          

        //     ////////for checking value ////////
        // for (var item in widget.gasTableData) {
        //   log('Checking item: ${item['name']}');
        //   for (var key in fieldKeys ?? []) {
        //     final val = item[key];
        //     log('  Key: $key → ${val.runtimeType}: $val');
        //   }
        // }
        log("filteredRows ())))) ${filteredRows.length} ()() ${widget.type}");
        log("filteredRows ()))))&&&&&& ${filteredGasTable.length} ()() $filteredGasTable");

        if (filteredRows.isEmpty) {
          return Center(
            child: Text("No valid data to display", style: txtStylegreen),
          );
        }
        return SingleChildScrollView(
          child: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth,),
              child: DataTableTheme(
                data: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(Color(0xff4c7c80)),
                  dataRowColor: WidgetStateProperty.all(Colors.black),
                  dividerThickness: 1,
                ),
                child:
                // isPaginated
                //     ? PaginatedDataTable(
                //       rowsPerPage: 10,
                //       columnSpacing: 20,
                //       showCheckboxColumn: false,
                //       sortColumnIndex: _sortColumnIndex,
                //       sortAscending: _sortAscending,
                //       columns: gasDataSource.getColumns((columnIndex, ascending) {
                //         setState(() {
                //           _sortColumnIndex = columnIndex;
                //           _sortAscending = ascending;
                //           gasDataSource.sort(columnIndex, ascending);
                //         });
                //       }),
                //       source: gasDataSource,
                //     )
                //     :
                DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 1.0,
                  columns: columns,
                  rows:
                      filteredRows.map((item) {
                        // log("getgasdata in rows ${widget.getGasData}");
                           
                            final matchingGasItem = filteredGasTable.firstWhere(
    (gasItem) {
      final isMatch = gasItem['NAME'] == item['name'] &&
                      gasItem['TYPE'] == item['Type'];  
      log("Matching check: ${gasItem['NAME']} == ${item['name']} && ${gasItem['TYPE']} == ${item['Type']} => $isMatch");
      return isMatch;
    },
    orElse: () => {},
  );
                            final suspiciousRows = getSuspiciousRows(filteredGasTable, matchingGasItem, widget.type);
                            //  log("suspiciousRows: ${matchingGasItem.length} ()))( $matchingGasItem)");
                            //  log("suspiciousRows: *****  ${widget.getGasData} ()))() $matchingGasItem ()(()) ${widget.type}");
                            // final isMatched = matchingGasItem.isNotEmpty;
                        return DataRow(
                          cells: gasDataSource.getRowCells(item,matchingGasItem,suspiciousRows,widget.type), 
                          onSelectChanged: (selected) {
                             if ((selected ?? false) && widget.onRowSelected != null) {
                          widget.onRowSelected!(item);
                        }
                           },
                        );
                      }).toList(), 
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GasDataSource extends DataTableSource {
  final BuildContext context;
  List<Map<String, dynamic>> gasTableData;
  List<Map<String, dynamic>> gasData;
  final String type;

  _GasDataSource(this.gasTableData,this.gasData, this.type, this.context);

  @override
  DataRow getRow(int index) {
    final item = gasTableData[index];
     final matchingItem = gasData.firstWhere(
    (e) => e['name'] == item['name'] && e['type'] == item['type'],
    orElse: () => {},
  );
   
    final suspiciousRows = getSuspiciousRows(gasData, matchingItem, type);
    log("suspiciousRows  $suspiciousRows");


    return DataRow.byIndex(
      index: index,
      cells: getRowCells(item,matchingItem,suspiciousRows,type),
      onSelectChanged: (selected) {
        if (selected ?? false) {
          print('Row clicked: ${item['name']}');
        }
      },
    );
  }

  List<DataCell> getRowCells(Map<String, dynamic> item, Map<String, dynamic> gasItem,List<Map<String, dynamic>> suspiciousRows, String type) {
    final fieldKeys = rowMap[type];
    // log("msg getrows *** itme $gasItem");
    // log("msg getrows *** $item");

    // final suspiciousItems = getSuspiciousRows(gasTableData, gasItem, type);

    final suspiciousParams = suspiciousRows.map((e) => e["PARAMETER_CODE"]).toSet();
  final suspiciousKeys = suspiciousParams.map((p) => parameterToKeyMap[p]).whereType<String>().toSet();


    // final filteredRows = gasTableData.where((item) {
    //   return fieldKeys!.every((key) {
    //     final value = item[key];
    //     return value != null && value.toString().trim().isNotEmpty;
    //   });
    // }).toList();

    // If type is not mapped, fallback to empty or all keys (as needed)
    if (fieldKeys != null) {
      return fieldKeys.map((key) {
        
        final value = item[key];
        // log("msg getrows (()()))() $value");
        final isNameField = key.toLowerCase() == 'name';
        final isSuspicious = suspiciousKeys.contains(key); 
        log("fieldKeys isSusus $isSuspicious");
        return DataCell(
          Text(
            value?.toString() ?? '',
            style: isSuspicious
              ? TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)
              : type == "COMP" ?  txtStyleWhiteB : isNameField ? txtStyleWhiteU : txtStylegreen,
            textScaler: TextScaler.linear(0.9),
          ),
        );
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
          label: Text(
            fields[index],
            style: txtStyleYellow,
            textScaler: TextScaler.linear(1.0),
          ),
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
List<Map<String, dynamic>> getSuspiciousRows(
  List<Map<String, dynamic>> gasData,
  Map<String, dynamic> data,
  String type,
) {
  final codes = parameterCodeMap[type];
  if (codes == null) return [];

  return gasData.where((item) {
    final regionMatch = item["REGION"] == (["INJT", "EPP", "GASQ", "CSCP"].contains(type)
        ? data["Parameter_Code"]
        : data["Region"]);
    final typeMatch = item["TYPE"] == data["Type"];
    final nameMatch = item["NAME"] == data["name"];
    final paramMatch = codes.contains(item["PARAMETER_CODE"]);
    return regionMatch && typeMatch && nameMatch && paramMatch;
  }).toList();
}
List<String> getSuspiciousKeysForType(String type) {
  final paramCodes = parameterCodeMap[type] ?? [];
  final suspiciousKeys = paramCodes
      .map((code) => parameterToKeyMap[code])
      .whereType<String>()
      .toSet()
      .toList();
  return suspiciousKeys;
}

