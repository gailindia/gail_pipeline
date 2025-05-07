import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/ui/mapType.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';
import 'package:get/get.dart';

class GasTableData extends StatefulWidget {
  final List<Map<String, dynamic>> gasTableData;
  final List<Map<String, dynamic>> getGasData;
  final String type;
  final void Function(Map<String, dynamic>)? onRowSelected;

  const GasTableData({
    required this.gasTableData,
    required this.getGasData,
    required this.type,
    this.onRowSelected,
    super.key,
  });

  @override
  State<GasTableData> createState() => _GasTableDataState();
}

class _GasTableDataState extends State<GasTableData> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  RxString matchHedrType = "".obs;
  RxString matchNameStn = "".obs;
  RxInt matchclmnIndx = 0.obs;


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
              // log("fieldkkk $fieldKeys");
              if (fieldKeys == null) return false;
              return fieldKeys.every((key) {
                final value = item[key];
                return value != null && value.toString().trim().isNotEmpty;
              });
            }).toList();
        final filteredGasTable =
            widget.getGasData.where((element) {
              //  log("fieldkkk  element ***$fieldKeys");

              final type = element['TYPE']?.toString().trim();
              final tagType = element['TAG_TYPE'] == "B"; 
              return type == widget.type.toString().trim() && tagType;
            }).toList();
 
        log("filteredRows ())))) ${filteredRows.length} ()()");
        log(
          "filteredRows ()))))&&&&&& ${filteredGasTable.length} ()() $filteredGasTable",
        );

        for (var gasStnItem in widget.gasTableData) {
          for (var gasItem in filteredGasTable) {
            final sameName = gasStnItem['name'] == gasItem['NAME'];
            final sameType = gasStnItem['Type'] == gasItem['TYPE'];
            final parameter = gasItem['PARAMETER_CODE'];
            final type = widget.type; 
            final isRegionMatch =
                gasStnItem['Region'] == gasItem['REGION'] ||
                gasStnItem['Parameter_Code'] == gasItem['REGION'];

            if (sameName && sameType && parameterCodeMap[type]?.contains(parameter) == true &&
                isRegionMatch &&
                gasItem['TAG_TYPE'] == "B") {
                   final paramKey = parameterCodeToFieldMap[parameter];
              final rowKeys = rowMap[widget.type];
              final headers = headersMap[widget.type]; 

              if (paramKey != null && rowKeys != null && headers != null) {
                final columnIndex = rowKeys.indexWhere(
                  (key) => key.trim() == paramKey,
                );

                if (columnIndex != -1 && columnIndex < headers.length) {
                  final header = headers[columnIndex]; 
                  log(
                    " Matched param: $parameter → key: $paramKey → column: $columnIndex → header: $header row $gasItem gggg $gasStnItem",
                  );
                  matchHedrType.value = header;
                  matchNameStn.value = gasStnItem['name'].toString().trim();
                  matchclmnIndx.value = columnIndex;
                  log(
                "msg type $type matched param: $parameter &&&&& ${gasItem['NAME']} ***** ${gasStnItem['name'] } ***** $header",
              );
                } else {
                  log("paramKey '$paramKey' not found in rowKeys: $rowKeys");
                }
              } else {
                log(
                  " Missing paramKey or rowMap/headerMap for type ${widget.type}",
                );
              }
            }
          }
        }
        if (filteredRows.isEmpty) {
          return Center(
            child: Text("No valid data to display", style: txtStylegreen),
          );
        }
        return SingleChildScrollView(
          child: SingleChildScrollView( 
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTableTheme(
                data: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(Color(0xff4c7c80)),
                  dataRowColor: WidgetStateProperty.all(Colors.black),
                  dividerThickness: 1,
                ),
                child: DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 1.0,
                  columns: columns,
                  rows:
                      filteredRows.map((item) {
                        return DataRow(
                          cells: gasDataSource.getRowCells(
                            item,
                            filteredGasTable,
                            widget.type,
                            matchHedrType.value,
                            matchNameStn.value,
                            matchclmnIndx.value
                          ),
                          onSelectChanged: (selected) {
                            if ((selected ?? false) &&
                                widget.onRowSelected != null) {
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

  _GasDataSource(this.gasTableData, this.gasData, this.type, this.context);

  @override
  DataRow getRow(int index) {
    final item = gasTableData[index];
    final matchingItem = gasData.firstWhere((e) {
      final isMatching = e['NAME'] == item['name'] && e['TYPE'] == item['Type'];

      return isMatching;
    }, orElse: () => {});

    if (matchingItem.isEmpty) {
      return DataRow.byIndex(index: index, cells: getRowCells(item, [], type,"","",0));
    }

    return DataRow.byIndex(
      index: index,
      cells: getRowCells(item, [], type,"","",0),
      // cells: getRowCells(item,matchingItem,type),
      onSelectChanged: (selected) {
        if (selected ?? false) {
          print('Row clicked: 666 ${item['name']}');
        }
      },
    );
  }

  List<DataCell> getRowCells(
    Map<String, dynamic> item,
    List<Map<String, dynamic>> gasItem,
    String type,
    String matchedHeader,
    String matchedHeaderName,
    int? matchedColumnIndex,
  ) {
    final fieldKeys = rowMap[type];
    final isMatchedRow = matchedHeader != "" ? matchedHeader : ""; 
    final isMatchName = matchedHeaderName != "" ? matchedHeaderName : "";
    

    if (fieldKeys != null) { 
      return fieldKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final key = entry.value;
      final value = item[key];
      final isNameField = key.toLowerCase() == 'name';


      final isTargetCell = matchedHeader.isNotEmpty &&
          matchedHeaderName.isNotEmpty && 
          matchedColumnIndex == index;

       log("→ item name: ${item['name']}, matchedHeaderName: $matchedHeaderName, matchedColumnIndex: $matchedColumnIndex, current index: $index, isTargetCell: $isTargetCell");

        return DataCell(
          Text(
            value?.toString() ?? '',
            style: isNameField
            ? (type == "COMP")
            ? txtStyleWhiteB
             : txtStyleWhiteU
             : isMatchedRow  != "" && item['name'] == isMatchName  
             ? isTargetCell
             ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
             :txtStylegreen
             :txtStylegreen,  
            textScaler: TextScaler.linear(0.9),
          ),
        );
      }).toList();
    } else {
      return item.values.map((value) {
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
