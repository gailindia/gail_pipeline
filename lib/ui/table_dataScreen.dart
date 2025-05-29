import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/ui/mapType.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';

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
  int sortColumnIndex = 0;
  bool sortAscending = true;
  final List<MatchedList> matchedItems = [];

  @override
  Widget build(BuildContext context) {
    final gasDataSource = _GasDataSource(
      widget.gasTableData,
      widget.getGasData,
      widget.type,
      context,
    );

    final columns = gasDataSource.getColumns((columnIndex, ascending) {
      setState(() {
        sortColumnIndex = columnIndex;
        sortAscending = ascending;
      });
    });

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
              final type = element['TYPE']?.toString().trim();
              final tagType = element['TAG_TYPE'] == "B";
              return type == widget.type.toString().trim() && tagType;
            }).toList();
        matchedItems.clear();
        /////////////////////////////sorting ////////////////////
        filteredRows.sort((a, b) {
          final fieldKeys = rowMap[widget.type];
          if (fieldKeys == null || sortColumnIndex >= fieldKeys.length)
            return 0;

          final key = fieldKeys[sortColumnIndex];
          final aValue = a[key]?.toString().toLowerCase() ?? '';
          final bValue = b[key]?.toString().toLowerCase() ?? '';

          return sortAscending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        });
        ////////////////////////////////////////
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

            if (sameName &&
                sameType &&
                parameterCodeMap[type]?.contains(parameter) == true &&
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
                  matchedItems.add(
                    MatchedList(
                      header,
                      gasStnItem['name'].toString(),
                      columnIndex,
                    ),
                  );
                  log("matched itmes $matchedItems");

                  log(
                    "msg type $type matched param: $parameter &&&&& ${gasItem['NAME']} ***** ${gasStnItem['name']} ***** $header",
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
                  columnSpacing: 20,
                  columns: columns, 
                  rows:
                      filteredRows.map((item) {
                        return DataRow(
                          cells: gasDataSource.getRowCells(
                            item,
                            filteredGasTable,
                            widget.type,
                            matchedItems,
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
      return DataRow.byIndex(
        index: index,
        cells: getRowCells(item, [], type, []),
      );
    }

    return DataRow.byIndex(
      index: index,
      cells: getRowCells(item, [], type, []),
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
    List<MatchedList> matchedItemList,
  ) {
    final fieldKeys = rowMap[type];

    if (fieldKeys != null) {
      return fieldKeys.asMap().entries.map((entry) {
        final index = entry.key;
        final key = entry.value;
        final value = item[key];
        final isNameField = key.toLowerCase() == 'name';
        final match = matchedItemList.firstWhere(
          (m) => m.matchNameStn == item['name'] && m.matchclmnIndx == index,
          orElse: () => MatchedList("", "", -1),
        );
        final isMatchedCell = match.matchclmnIndx != -1;

        // log("getrows **** ${matchedItemList.length} ");
        ///////////////////////////////////////////////////////////

        // log("formattedValue $isNameField *** $formattedValue ");

        String formattedValue = value?.toString() ?? '';
        if (isNameField &&
            formattedValue.length > 8 &&
            (formattedValue.contains(' ') || formattedValue.contains('-'))) {
          int breakIndex =
              formattedValue.contains(' ')
                  ? formattedValue.indexOf(' ')
                  : formattedValue.indexOf('-');

          if (breakIndex != -1) {
            formattedValue =
                '${formattedValue.substring(0, breakIndex)}\n${formattedValue.substring(breakIndex + 1)}';
          }
        }
        return DataCell(
          Text(
            // value?.toString() ?? '',
            formattedValue,
            style:
                isNameField
                    ? (type == "COMP")
                        ? txtStyleWhiteB
                        : txtStyleWhiteU
                    : isMatchedCell
                    ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                    : txtStylegreen,
            maxLines: isNameField ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true, 
            textScaler: TextScaler.linear(1.0),
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
            textAlign: TextAlign.center,
          ),
          onSort:
              (columnIndex, ascending) =>
                  onSortCallback(columnIndex, ascending),
          numeric: false,
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

class MatchedList {
  final String matchHedrType;
  final String matchNameStn;
  final int matchclmnIndx;

  const MatchedList(this.matchHedrType, this.matchNameStn, this.matchclmnIndx);
}
