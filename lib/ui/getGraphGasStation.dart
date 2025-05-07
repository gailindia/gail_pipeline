// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gail_pipeline/ui/mapType.dart';
// import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';



// class GasTableData extends StatefulWidget {
//   final List<Map<String, dynamic>> gasTableData;
//   final List <Map<String,dynamic>> getGasData;
//   final String type;
//   final void Function(Map<String, dynamic>)? onRowSelected;

//   const GasTableData({
//     required this.gasTableData,
//     required this.getGasData,
//     required this.type,this.onRowSelected,
//     super.key,
//   });

//   @override
//   State<GasTableData> createState() => _GasTableDataState();
// }

// class _GasTableDataState extends State<GasTableData> {
//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;

   

//   @override
//   Widget build(BuildContext context) {

 
//     final gasDataSource = _GasDataSource(
//       widget.gasTableData,
//       widget.getGasData,
//       widget.type,
//       context,
//     );

//     final columns = gasDataSource.getColumns((columnIndex, ascending) {});

//     if (columns.isEmpty) {
//       return const Center(child: Text("No columns to display"));
//     }
//     final isPaginated = widget.gasTableData.length > 5;

//     return LayoutBuilder(
//       builder: (context, constraints) {
        
//         final fieldKeys = rowMap[widget.type];
//         final filteredRows =
//             widget.gasTableData.where((item) {
//               // log("fieldkkk $fieldKeys");
//               if (fieldKeys == null) return false;
//               return fieldKeys.every((key) {
//                 final value = item[key];
//                 return value != null && value.toString().trim().isNotEmpty;
//               });
//             }).toList();
//         final filteredGasTable = widget.getGasData.where((element) {
//           //  log("fieldkkk  element ***$fieldKeys");
            
//             final type = element['TYPE']?.toString().trim() ;
//             final tagType = element['TAG_TYPE'] == "B";
//             // final Region = element['REGION']?.toString().trim();
//             // final parameterCode = element['PARAMETER_CODE']?.toString().trim();
//             // return type == "CSCP" && Region == "CGD" && parameterCode == "PRSS";
//             return type == widget.type.toString().trim() && tagType;
//           }).toList();
          

//         //     ////////for checking value ////////
//         // for (var item in widget.gasTableData) {
//         //   log('Checking item: ${item['name']}');
//         //   for (var key in fieldKeys ?? []) {
//         //     final val = item[key];
//         //     log('  Key: $key → ${val.runtimeType}: $val');
//         //   }
//         // }
//         log("filteredRows ())))) ${filteredRows.length} ()()");
//         log("filteredRows ()))))&&&&&& ${filteredGasTable.length} ()() $filteredGasTable");
//     //       for (var gasStnItem in widget.gasTableData) {
//     // for (var gasItem in filteredGasTable) {
//     //   if (gasStnItem['name'] == gasItem['NAME'] && 
//     //       gasStnItem['Type'] == gasItem['TYPE']  ) {
//     //         if(widget.type == "COMP" && gasStnItem['Region'] == gasItem['REGION']){
//     //           if( 
//     //             gasItem['PARAMETER_CODE'] == "INLTP"){
//     //                 log("msg type comp iffff inltp");
//     //             }
//     //           else if(  
//     //             gasItem['PARAMETER_CODE'] == "OUTLP"){
//     //                 log("msg type comp else iffff Outlp");
//     //             } 
//     //           else if(
//     //             gasItem['PARAMETER_CODE'] == "FLOW"){
//     //                 log("msg type comp else iffff FLOW");
//     //             }  
//     //         }
//     //        else if(widget.type == "INJT"){
//     //           if(gasStnItem['Parameter_Code'] == gasItem['REGION'] && 
//     //             gasItem['PARAMETER_CODE'] == "INLTP"){
//     //                 log("msg type injt iffff inltp");
//     //             }
//     //           else if(gasStnItem['Region'] == gasItem['REGION'] && 
//     //             gasItem['PARAMETER_CODE'] == "Flow"){
//     //                 log("msg type injt else iffff Flow");
//     //             } 
              
//     //         }
//     //        else if(widget.type == "GPU" && gasStnItem['Region'] == gasItem['REGION']){
//     //           if( 
//     //             gasItem['PARAMETER_CODE'] == "FDGPR"){
//     //                 log("msg type gpu else iffff FDGPR");
//     //             } 
//     //          else if( 
//     //             gasItem['PARAMETER_CODE'] == "FDGVL"){
//     //                 log("msg type gpu else iffff FDGVL");
//     //             } 
//     //          else if( 
//     //             gasItem['PARAMETER_CODE'] == "FDGCF"){
//     //                 log("msg type gpu else iffff FDGCF");
//     //             } 
//     //          else if(
//     //             gasItem['PARAMETER_CODE'] == "PLTPN"){
//     //                 log("msg type gpu else iffff PLTPN");
//     //             } 
              
//     //         }
//     //        else if(widget.type == "EPP" && gasStnItem['Parameter_Code'] == gasItem['REGION']){
//     //           if(  
//     //             gasItem['PARAMETER_CODE'] == "EPPR"){
//     //                 log("msg type epp iffff EPPR");
//     //             }
//     //            else if( 
//     //             gasItem['PARAMETER_CODE'] == "EPFW"){
//     //                 log("msg type epp iffff EPFW");
//     //             }
              
//     //         }
//     //        else if(widget.type == "CSCP"){
//     //           if(gasStnItem['Parameter_Code'] == gasItem['REGION'] && 
//     //             gasItem['PARAMETER_CODE'] == "PRSS"){

//     //                 log("msg type cscp iffff PRSS $gasItem");
//     //             }
//     //           if(gasStnItem['Region'] == gasItem['REGION'] && 
//     //             gasItem['PARAMETER_CODE'] == "CFLW"){
//     //                 log("msg type cscp iffff CFLW");
//     //             }
              
//     //         }
//     //         else if(widget.type == "GASQ" && gasStnItem['Region'] == gasItem['REGION']){
//     //           if(
//     //             gasItem['PARAMETER_CODE'] == "GAC3"){
//     //                 log("msg type gasq iffff GAC3");
//     //             }
//     //          else if(
//     //             gasItem['PARAMETER_CODE'] == "GAC4"){
//     //                 log("msg type gasq iffff GAC4");
//     //             }
              
//     //         }
//     //        else if(widget.type == "LPK" && gasStnItem['Region'] == gasItem['REGION']){
//     //           if(
//     //             gasItem['PARAMETER_CODE'] == "LNPK"){
//     //                 log("msg type lpk iffff LNPK");
//     //             }
//     //         }
//     //         else if(widget.type == "RMXN" &&  gasStnItem['Region'] == gasItem['REGION']){
//     //           if(
//     //             gasItem['PARAMETER_CODE'] == "RLMIX"){
//     //                 log("msg type RMXN iffff RLMIX");
//     //             }
//     //         }
//     //         if(gasItem['PARAMETER_CODE'] == "PRSS" && gasItem['TAG_TYPE'] == "B"){
//     //           log('Match found! $gasItem ___ $gasStnItem');
//     //           log('Item 1 TAG_TYPE: ${gasStnItem['TAG_TYPE']}');
//     //           log('Item 2 TAG_TYPE: ${gasStnItem['TAG_TYPE']}');
//     //         }
       
//     //     // You can add comparison logic here
//     //   }
//     // }
//     //       }
//     //       // widget.gasTableData.clear();
//     //       // filteredGasTable.clear();

// for (var gasStnItem in widget.gasTableData) {
//   for (var gasItem in filteredGasTable) {
//     final sameName = gasStnItem['name'] == gasItem['NAME'];
//     final sameType = gasStnItem['Type'] == gasItem['TYPE'];
//     final parameter = gasItem['PARAMETER_CODE'];
//     final type = widget.type;

//     if (!sameName || !sameType) continue;

//     final isRegionMatch = gasStnItem['Region'] == gasItem['REGION'] ||
//                           gasStnItem['Parameter_Code'] == gasItem['REGION'];

//     if (parameterCodeMap[type]?.contains(parameter) == true && isRegionMatch) {
//       log("msg type $type matched param: $parameter &&&&& $gasItem ***** $gasStnItem");
//     }
//   }
// }
//         if (filteredRows.isEmpty) {
//           return Center(
//             child: Text("No valid data to display", style: txtStylegreen),
//           );
//         }
//         return SingleChildScrollView(
//           child: SingleChildScrollView(
//             // padding: EdgeInsets.symmetric(horizontal: 15),
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minWidth: constraints.maxWidth,),
//               child: DataTableTheme(
//                 data: DataTableThemeData(
//                   headingRowColor: WidgetStateProperty.all(Color(0xff4c7c80)),
//                   dataRowColor: WidgetStateProperty.all(Colors.black),
//                   dividerThickness: 1,
//                 ),
//                 child:
//                 // isPaginated
//                 //     ? PaginatedDataTable(
//                 //       rowsPerPage: 10,
//                 //       columnSpacing: 20,
//                 //       showCheckboxColumn: false,
//                 //       sortColumnIndex: _sortColumnIndex,
//                 //       sortAscending: _sortAscending,
//                 //       columns: gasDataSource.getColumns((columnIndex, ascending) {
//                 //         setState(() {
//                 //           _sortColumnIndex = columnIndex;
//                 //           _sortAscending = ascending;
//                 //           gasDataSource.sort(columnIndex, ascending);
//                 //         });
//                 //       }),
//                 //       source: gasDataSource,
//                 //     )
//                 //     :
//                 DataTable(
//                   showCheckboxColumn: false,
//                   columnSpacing: 1.0,
//                   columns: columns,
//                   rows:
//                       filteredRows.map((item) {
//                         // log("getgasdata in rows ${widget.getGasData}");
                           
//   //                           final matchingGasItem = filteredGasTable.firstWhere(
//   //   (gasItem) {
//   //     final isMatch = gasItem['NAME'] == item['name'] &&
//   //                     gasItem['TYPE'] == item['Type'];  
//   //     log("Matching check: ${gasItem['NAME']} == ${item['name']} && ${gasItem['TYPE']} == ${item['Type']} => $isMatch");
//   //     return isMatch;
//   //   },
//   //   orElse: () => {},
//   // );

  
//   //                           final suspiciousRows = getSuspiciousRows(filteredRows, filteredGasTable, widget.type);
//   //                           final suspiciousParamCodes = suspiciousRows.map((e) => e["PARAMETER_CODE"]).toSet();
//   // final suspiciousKeys = suspiciousParamCodes.map((code) => parameterToKeyMap[code]).whereType<String>().toSet();
//   //   final hasSuspiciousValue = suspiciousKeys.any((key) {
//   //   final value = item[key];
//   //   return value != null && value.toString().trim().isNotEmpty;
//   // });
//   //                            log("suspiciousRows: &&&&& $suspiciousRows ()))( $suspiciousParamCodes )) $hasSuspiciousValue");
//                             //  log("suspiciousRows: *****  ${widget.getGasData} ()))() $matchingGasItem ()(()) ${widget.type}");
//                             // final isMatched = matchingGasItem.isNotEmpty;
//                         return DataRow(
//                           cells: gasDataSource.getRowCells(item,filteredGasTable,widget.type), 
//                           onSelectChanged: (selected) {
//                              if ((selected ?? false) && widget.onRowSelected != null) {
//                           widget.onRowSelected!(item);
//                         }
//                            },
//                         );
//                       }).toList(), 
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _GasDataSource extends DataTableSource {
//   final BuildContext context;
//   List<Map<String, dynamic>> gasTableData;
//   List<Map<String, dynamic>> gasData;
//   final String type;

//   _GasDataSource(this.gasTableData,this.gasData, this.type, this.context);

//   @override
//   DataRow getRow(int index) {
//     final item = gasTableData[index];
//      final matchingItem = gasData.firstWhere(
//     (e) {
//        final isMatching = e['NAME'] == item['name'] && e['TYPE'] == item['Type'];
//       //  gasItem['NAME'] == item['name'] &&
//       //                 gasItem['TYPE'] == item['Type'];  
//       // log("Matching check: ****${ e['NAME']} == ${item['name']} && ${e['TYPE']} == ${item['Type']} => $isMatching");
//       return isMatching;
      
//     } ,
//     orElse: () => {},
//   );
//   // log("matchingItem **** $matchingItem");
//      if (matchingItem.isEmpty) {
//   return DataRow.byIndex(
//     index: index,
//     cells: getRowCells(item, [], type),
//   );
// }
   
//   //   final suspiciousRows = getSuspiciousRows(gasData, matchingItem, type);
//   //   // STEP 1: Get PARAMETER_CODEs for this type
//   // final suspiciousParamCodes = suspiciousRows.map((e) => e["PARAMETER_CODE"]).toSet();

//   // // STEP 2: Convert PARAMETER_CODEs to field keys in row
//   // final suspiciousKeys = suspiciousParamCodes.map((code) => parameterToKeyMap[code])
//   //     .whereType<String>()
//   //     .toSet();

//   // // STEP 3: Check if this item has any of those suspicious keys
//   // final hasSuspiciousValue = suspiciousKeys.any((key) {
//   //   final value = item[key];
//   //   return value != null && value.toString().trim().isNotEmpty;
//   // });
//     // log("suspiciousRows  $suspiciousRows");

 



//     return DataRow.byIndex(
//       index: index,
//       // color: MaterialStateProperty.resolveWith<Color?>(
//       // (Set<MaterialState> states) {
//       //   return hasSuspiciousValue ? Colors.red.withOpacity(0.3) : null;
//       // },
//     // ),
//       cells: getRowCells(item,[],type),
//       // cells: getRowCells(item,matchingItem,type),
//       onSelectChanged: (selected) {
//         if (selected ?? false) {
//           print('Row clicked: 666 ${item['name']}');
//         }
//       },
//     );
//   }

//   List<DataCell> getRowCells(Map<String, dynamic> item, List<Map<String, dynamic>> gasItem, String type) {
//     final fieldKeys = rowMap[type];
//       // STEP 1: Get suspicious PARAMETER_CODEs for this type
//   // final suspiciousParamCodes = parameterCodeMap[type]?.toSet() ?? {};

//   // // STEP 2: Convert PARAMETER_CODEs to field keys in row
//   // final suspiciousKeys = suspiciousParamCodes.map((code) => parameterToKeyMap[code])
//   //     .whereType<String>()
//   //     .toSet();
//   //   // log("msg getrows *** itme $gasItem");
//   //   log("msg getrows *** $suspiciousKeys");

//     // final suspiciousItems = getSuspiciousRows(gasTableData, gasItem, type);

//     // final suspiciousParams = suspiciousRows.map((e) => e["PARAMETER_CODE"]).toSet();
//   // final suspiciousKeys = suspiciousParams.map((p) => parameterToKeyMap[p]).whereType<String>().toSet();


//     // final filteredRows = gasTableData.where((item) {
//     //   return fieldKeys!.every((key) {
//     //     final value = item[key];
//     //     return value != null && value.toString().trim().isNotEmpty;
//     //   });
//     // }).toList();

//     // If type is not mapped, fallback to empty or all keys (as needed)
//     if (fieldKeys != null) {
//       return fieldKeys.map((key) {
        
//         final value = item[key];
//         // log("msg getrows (()()))() $value");
//         final isNameField = key.toLowerCase() == 'name';
//         // final isSuspicious = suspiciousKeys.contains(key); 
//         // log("fieldKeys isSusus $isSuspicious");
//         return DataCell(
//           Text(
//             value?.toString() ?? '',
//             style:
//             //  isSuspicious
//             //   ? TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)
//             //   :
//                type == "COMP" ?  txtStyleWhiteB : isNameField ? txtStyleWhiteU : txtStylegreen,
//             textScaler: TextScaler.linear(0.9),
//           ),
//         );
//       }).toList();
//     } else {
//       return item.values.map((value) {
//         // log("item**** ${item['name']}  &&&& ${item['Region']}");
//         return DataCell(Text(value?.toString() ?? ''));
//       }).toList();
//     }
//   }

//   List<DataColumn> getColumns(void Function(int, bool) onSortCallback) {
//     final fields = headersMap[type];

//     if (fields != null) {
//       return List.generate(fields.length, (index) {
//         return DataColumn(
//           label: Text(
//             fields[index],
//             style: txtStyleYellow,
//             textScaler: TextScaler.linear(1.0),
//           ),
//           onSort:
//               (columnIndex, ascending) =>
//                   onSortCallback(columnIndex, ascending),
//         );
//       });
//     } else {
//       if (gasTableData.isEmpty) {
//         return [];
//       }

//       return gasTableData.first.keys.map((key) {
//         return DataColumn(
//           label: Text(key),
//           onSort:
//               (columnIndex, ascending) =>
//                   onSortCallback(columnIndex, ascending),
//         );
//       }).toList();
//     }
//   }

//   void sort(int columnIndex, bool ascending) {
//     if (type == "COMP") {
//       final fields = ['name', 'sp', 'dp', 'fr'];
//       gasTableData.sort((a, b) {
//         final aValue = a[fields[columnIndex]];
//         final bValue = b[fields[columnIndex]];
//         return ascending
//             ? aValue.toString().compareTo(bValue.toString())
//             : bValue.toString().compareTo(aValue.toString());
//       });
//     } else {
//       final keys = gasTableData.first.keys.toList();
//       gasTableData.sort((a, b) {
//         final aValue = a[keys[columnIndex]];
//         final bValue = b[keys[columnIndex]];
//         return ascending
//             ? aValue.toString().compareTo(bValue.toString())
//             : bValue.toString().compareTo(aValue.toString());
//       });
//     }
//     notifyListeners();
//   }

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => gasTableData.length;
//   @override
//   int get selectedRowCount => 0;
// }

// List<Map<String, dynamic>> getSuspiciousRows(
//   List<Map<String, dynamic>> gasStationData,
//   List<Map<String, dynamic>> matchingData, 
//   String type,
// ) {
//   final codes = parameterCodeMap[type];
//   if (codes == null) return [];


   
  
//   // log("Checking suspicious rows for: $matchingData");
//   // log("Checking suspicious rows for: gsss ${gasStationData.length} $gasStationData");

//     // return gasStationData.where((item) {
    

      
//       // final regionMatch = item["Region"] == 
//       //   (["COMP","INJT", "EPP", "GASQ", "CSCP", "GPU","LPK"].contains(type)
//       //       ? matchingData["PARAMETER_CODE"]
//       //       : matchingData["REGION"]);
//       // final typeMatch = item["Type"] == matchingData["TYPE"];
//   //     final nameMatch = item["name"] == matchingData["NAME"];
//   //     final paramMatch = codes.contains(item["Parameter_Code"]);
//   //     log("Raw item: $item");

//   //    log("Checking suspicious row:\n"
//   //   "Region: ${item["Region"]} == ${["COMP","INJT", "EPP", "GASQ", "CSCP", "GPU","LPK"].contains(type) ? matchingData["PARAMETER_CODE"] : matchingData["REGION"]}\n"
//   //   "Type: ${item["Type"]} == ${matchingData["TYPE"]}\n"
//   //   "Name: ${item["name"]} == ${matchingData["NAME"]}\n"
//   //   "Param: ${item["Parameter_Code"]} in $codes");
//   //     return regionMatch && typeMatch && nameMatch && paramMatch;
        
    
//   // }).toList();


//   const targetParameterCodes = {"FDGPR", "FDGVL", "FDGCF", "PLTPN"};
// //   item.REGION == data.Region &&
// // item.TYPE == data.Type &&
// // item.PARAMETER_CODE == "FDGPR" &&
// // item.NAME == data.name
// // );
//   log("gasStationData: gsss $matchingData");

//   return gasStationData.where((item) {
//     log("gasStationData: $item");

//   //   final regionMatch = normalizeKey(item["Region"]) == normalizeKey(matchingData["REGION"]);
//   //   final typeMatch = normalizeKey(item["Type"]) == normalizeKey(matchingData["TYPE"]);
//   //   final nameMatch = normalizeKey(item["name"]) == normalizeKey(matchingData["NAME"]);
//   //   // final paramMatch = codes.contains(item["Parameter_Code"]); 
//   //   // final paramMatch = targetParameterCodes.contains(normalizeKey(item["Parameter_Code"]));
//   //   final paramMatch = matchingData["PARAMETER_CODE"] == 'PRSS'; 
//   //   // log("paramMatch $paramMatch 888888 ");  
//   //   log("regionMatch: ${regionMatch && typeMatch && nameMatch && paramMatch}");
//   // log("typeMatch: $typeMatch");
//   // log("nameMatch: $nameMatch");
//   // log("paramMatch: $paramMatch");
//   // log('Comparing region: "${item['Region']}" vs "${matchingData["REGION"]}"');

//   //  log("Checking suspicious row:\n"
//   //     "Region: ${item["Region"]} == ${matchingData["REGION"]} => $regionMatch\n"
//   //     "Type: ${item["Type"]} == ${matchingData["TYPE"]} => $typeMatch\n"
//   //     "Name: ${item["name"]} == ${matchingData["NAME"]} => $nameMatch\n"
//   //     "Param: ${item["Parameter_Code"]} in $targetParameterCodes => $paramMatch");

//     // return regionMatch && typeMatch && nameMatch && paramMatch;
//     return true;
//   }).toList();

//   // return gasData.where((item) {
//   //   final regionMatch = item["REGION"] == (["INJT", "EPP", "GASQ", "CSCP","GPU"].contains(type)
//   //       ? data["PARAMETER_CODE"]
//   //       : data["Region"]);
//   //   final typeMatch = item["TYPE"] == data["Type"];
//   //   final nameMatch = item["NAME"] == data["name"];
//   //   final paramMatch = codes.contains(item["PARAMETER_CODE"]);
//   //   return regionMatch && typeMatch && nameMatch && paramMatch;
//   // }).toList();
// }
// List<String> getSuspiciousKeysForType(String type) {
//   final paramCodes = parameterCodeMap[type] ?? [];
//   final suspiciousKeys = paramCodes
//       .map((code) => parameterToKeyMap[code])
//       .whereType<String>()
//       .toSet()
//       .toList();
//   return suspiciousKeys;
// }

/////////////////////////////////////////////*************************07-may25*****//////////////////////////////////////////////////////////

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gail_pipeline/ui/mapType.dart';
// import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';
// import 'package:get/get.dart';

// class GasTableData extends StatefulWidget {
//   final List<Map<String, dynamic>> gasTableData;
//   final List<Map<String, dynamic>> getGasData;
//   final String type;
//   final void Function(Map<String, dynamic>)? onRowSelected;

//   const GasTableData({
//     required this.gasTableData,
//     required this.getGasData,
//     required this.type,
//     this.onRowSelected,
//     super.key,
//   });

//   @override
//   State<GasTableData> createState() => _GasTableDataState();
// }

// class _GasTableDataState extends State<GasTableData> {
//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;
//   RxString matchHedrType = "".obs;
//   RxString matchNameStn = "".obs;
//   RxInt matchclmnIndx = 0.obs;


//   @override
//   Widget build(BuildContext context) {
//     final gasDataSource = _GasDataSource(
//       widget.gasTableData,
//       widget.getGasData,
//       widget.type,
//       context,
//     );

//     final columns = gasDataSource.getColumns((columnIndex, ascending) {});

//     if (columns.isEmpty) {
//       return const Center(child: Text("No columns to display"));
//     }
//     final isPaginated = widget.gasTableData.length > 5;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final fieldKeys = rowMap[widget.type];
//         final filteredRows =
//             widget.gasTableData.where((item) {
//               // log("fieldkkk $fieldKeys");
//               if (fieldKeys == null) return false;
//               return fieldKeys.every((key) {
//                 final value = item[key];
//                 return value != null && value.toString().trim().isNotEmpty;
//               });
//             }).toList();
//         final filteredGasTable =
//             widget.getGasData.where((element) {
//               //  log("fieldkkk  element ***$fieldKeys");

//               final type = element['TYPE']?.toString().trim();
//               final tagType = element['TAG_TYPE'] == "B";
//               // final Region = element['REGION']?.toString().trim();
//               // final parameterCode = element['PARAMETER_CODE']?.toString().trim();
//               // return type == "CSCP" && Region == "CGD" && parameterCode == "PRSS";
//               return type == widget.type.toString().trim() && tagType;
//             }).toList();

//         //     ////////for checking value ////////
//         // for (var item in widget.gasTableData) {
//         //   log('Checking item: ${item['name']}');
//         //   for (var key in fieldKeys ?? []) {
//         //     final val = item[key];
//         //     log('  Key: $key → ${val.runtimeType}: $val');
//         //   }
//         // }
//         log("filteredRows ())))) ${filteredRows.length} ()()");
//         log(
//           "filteredRows ()))))&&&&&& ${filteredGasTable.length} ()() $filteredGasTable",
//         );

//         for (var gasStnItem in widget.gasTableData) {
//           for (var gasItem in filteredGasTable) {
//             final sameName = gasStnItem['name'] == gasItem['NAME'];
//             final sameType = gasStnItem['Type'] == gasItem['TYPE'];
//             final parameter = gasItem['PARAMETER_CODE'];
//             final type = widget.type;

//             // if (!sameName || !sameType ) continue;
//             //         if (!sameName || !sameType || !regionMatch) continue;
//             //             final paramKey = parameterToKeyMap[parameter];
//             // final rowKeys = rowMap[widget.type];
//             // final headers = headersMap[widget.type];

//             // if (paramKey != null && rowKeys != null && headers != null) {
//             //   final columnIndex = rowKeys.indexOf(paramKey);
//             //   if (columnIndex != -1) {
//             //     final header = headers[columnIndex];
//             //     log("Matched param: $parameter → key: $paramKey → column: $columnIndex → header: $header");
//             //   }
//             // }

//             final isRegionMatch =
//                 gasStnItem['Region'] == gasItem['REGION'] ||
//                 gasStnItem['Parameter_Code'] == gasItem['REGION'];

//             if (sameName && sameType && parameterCodeMap[type]?.contains(parameter) == true &&
//                 isRegionMatch &&
//                 gasItem['TAG_TYPE'] == "B") {
//                    final paramKey = parameterCodeToFieldMap[parameter];
//               final rowKeys = rowMap[widget.type];
//               final headers = headersMap[widget.type];
              
             
//               log(" Matching param: $parameter");
//               log(" Mapped paramKey: $paramKey");
//               log(" rowKeys for ${widget.type}: $rowKeys");

//               if (paramKey != null && rowKeys != null && headers != null) {
//                 final columnIndex = rowKeys.indexWhere(
//                   (key) => key.trim() == paramKey,
//                 );

//                 if (columnIndex != -1 && columnIndex < headers.length) {
//                   final header = headers[columnIndex];
//                   // msg type COMP matched param: FLOW &&&&& CHAINSA ***** CHAINSA

//                   // Matched param: FLOW → key: Flow → column: 3 → header: FR
//                   log(
//                     " Matched param: $parameter → key: $paramKey → column: $columnIndex → header: $header row $gasItem gggg $gasStnItem",
//                   );
//                   matchHedrType.value = header;
//                   matchNameStn.value = gasStnItem['name'].toString().trim();
//                   matchclmnIndx.value = columnIndex;
//                   log(
//                 "msg type $type matched param: $parameter &&&&& ${gasItem['NAME']} ***** ${gasStnItem['name'] } ***** $header",
//               );
//                 } else {
//                   log("paramKey '$paramKey' not found in rowKeys: $rowKeys");
//                 }
//               } else {
//                 log(
//                   " Missing paramKey or rowMap/headerMap for type ${widget.type}",
//                 );
//               }
//             }
//           }
//         }
//         if (filteredRows.isEmpty) {
//           return Center(
//             child: Text("No valid data to display", style: txtStylegreen),
//           );
//         }
//         return SingleChildScrollView(
//           child: SingleChildScrollView(
//             // padding: EdgeInsets.symmetric(horizontal: 15),
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minWidth: constraints.maxWidth),
//               child: DataTableTheme(
//                 data: DataTableThemeData(
//                   headingRowColor: WidgetStateProperty.all(Color(0xff4c7c80)),
//                   dataRowColor: WidgetStateProperty.all(Colors.black),
//                   dividerThickness: 1,
//                 ),
//                 child: DataTable(
//                   showCheckboxColumn: false,
//                   columnSpacing: 1.0,
//                   columns: columns,
//                   rows:
//                       filteredRows.map((item) {
//                         return DataRow(
//                           cells: gasDataSource.getRowCells(
//                             item,
//                             filteredGasTable,
//                             widget.type,
//                             matchHedrType.value,
//                             matchNameStn.value,
//                             matchclmnIndx.value
//                           ),
//                           onSelectChanged: (selected) {
//                             if ((selected ?? false) &&
//                                 widget.onRowSelected != null) {
//                               widget.onRowSelected!(item);
//                             }
//                           },
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _GasDataSource extends DataTableSource {
//   final BuildContext context;
//   List<Map<String, dynamic>> gasTableData;
//   List<Map<String, dynamic>> gasData;
//   final String type;

//   _GasDataSource(this.gasTableData, this.gasData, this.type, this.context);

//   @override
//   DataRow getRow(int index) {
//     final item = gasTableData[index];
//     final matchingItem = gasData.firstWhere((e) {
//       final isMatching = e['NAME'] == item['name'] && e['TYPE'] == item['Type'];

//       return isMatching;
//     }, orElse: () => {});

//     if (matchingItem.isEmpty) {
//       return DataRow.byIndex(index: index, cells: getRowCells(item, [], type,"","",0));
//     }

//     return DataRow.byIndex(
//       index: index,
//       cells: getRowCells(item, [], type,"","",0),
//       // cells: getRowCells(item,matchingItem,type),
//       onSelectChanged: (selected) {
//         if (selected ?? false) {
//           print('Row clicked: 666 ${item['name']}');
//         }
//       },
//     );
//   }

//   List<DataCell> getRowCells(
//     Map<String, dynamic> item,
//     List<Map<String, dynamic>> gasItem,
//     String type,
//     String matchedHeader,
//     String matchedHeaderName,
//     int? matchedColumnIndex,
//   ) {
//     final fieldKeys = rowMap[type];
//     final isMatchedRow = matchedHeader != "" ? matchedHeader : ""; 
//     final isMatchName = matchedHeaderName != "" ? matchedHeaderName : "";
    

//     if (fieldKeys != null) {
//       log("getRowCells ** $isMatchedRow ");
//       log("getRowCells ** ^^^ $isMatchName  () $item ");
//       log("getRowCells ** ^^(()^ $matchedColumnIndex ");
     
//       // return fieldKeys.map((key) {
//       //   var index = 3;
//       //   final value = item[key];
//       //   final isNameField = key.toLowerCase() == 'name';
//       //   // final namedH = item['name'] == isMatchName
//       //    log("isNameField ** ${item['name']}");
//       //     // Get the header text from headersMap
//       //  final isTargetCell = type == isMatchedRow && index == 1;
//       return fieldKeys.asMap().entries.map((entry) {
//       final index = entry.key;
//       final key = entry.value;
//       final value = item[key];
//       final isNameField = key.toLowerCase() == 'name';


//       final isTargetCell = matchedHeader.isNotEmpty &&
//           matchedHeaderName.isNotEmpty &&
//           // type == matchedHeader &&
//           // item['name']?.toString().trim() == matchedHeaderName &&
//           matchedColumnIndex == index;

//       log("→ item name: indx ${item['name']}, matchedHeaderName: $matchedHeaderName, matchedColumnIndex: $matchedColumnIndex, current index: $index, isTargetCell: $isTargetCell");
//       log("→ item name: ${item['name']}, matchedHeaderName: $matchedHeaderName, matchedColumnIndex: $matchedColumnIndex, current index: $index, isTargetCell: $isTargetCell");

//         return DataCell(
//           Text(
//             value?.toString() ?? '',
//             style: isNameField
//             ? (type == "COMP")
//             ? txtStyleWhiteB
//              : txtStyleWhiteU
//              : isMatchedRow  != "" && item['name'] == isMatchName  
//              ? isTargetCell
//              ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
//              :txtStylegreen
//              :txtStylegreen,
                 
//           //  (type == "COMP"
//           //         ? txtStyleWhiteB
//           //         : isNameField
//           //             ? txtStyleWhiteU
//           //             :  isMatchedRow  != "" && item['name'] == isMatchName  
//           //     ? isTargetCell
//           //    ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
//           //     : txtStylegreen :txtStylegreen ), 
//             textScaler: TextScaler.linear(0.9),
//           ),
//         );
//       }).toList();
//     } else {
//       return item.values.map((value) {
//         return DataCell(Text(value?.toString() ?? ''));
//       }).toList();
//     }
//   }

//   List<DataColumn> getColumns(void Function(int, bool) onSortCallback) {
//     final fields = headersMap[type];

//     if (fields != null) {
//       return List.generate(fields.length, (index) {
//         return DataColumn(
//           label: Text(
//             fields[index],
//             style: txtStyleYellow,
//             textScaler: TextScaler.linear(1.0),
//           ),
//           onSort:
//               (columnIndex, ascending) =>
//                   onSortCallback(columnIndex, ascending),
//         );
//       });
//     } else {
//       if (gasTableData.isEmpty) {
//         return [];
//       }

//       return gasTableData.first.keys.map((key) {
//         return DataColumn(
//           label: Text(key),
//           onSort:
//               (columnIndex, ascending) =>
//                   onSortCallback(columnIndex, ascending),
//         );
//       }).toList();
//     }
//   }

//   void sort(int columnIndex, bool ascending) {
//     if (type == "COMP") {
//       final fields = ['name', 'sp', 'dp', 'fr'];
//       gasTableData.sort((a, b) {
//         final aValue = a[fields[columnIndex]];
//         final bValue = b[fields[columnIndex]];
//         return ascending
//             ? aValue.toString().compareTo(bValue.toString())
//             : bValue.toString().compareTo(aValue.toString());
//       });
//     } else {
//       final keys = gasTableData.first.keys.toList();
//       gasTableData.sort((a, b) {
//         final aValue = a[keys[columnIndex]];
//         final bValue = b[keys[columnIndex]];
//         return ascending
//             ? aValue.toString().compareTo(bValue.toString())
//             : bValue.toString().compareTo(aValue.toString());
//       });
//     }
//     notifyListeners();
//   }

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => gasTableData.length;
//   @override
//   int get selectedRowCount => 0;
// }
