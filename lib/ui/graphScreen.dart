import 'dart:developer';

 
import 'package:flutter/material.dart';
import 'package:gail_pipeline/model/graph_respModel.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GasInjectionGraph extends StatefulWidget {
  final List<GraphRespModel> graphRespModel;
  final String dataKey;
  final Color areaColor;
  // final String yUnit;

  const GasInjectionGraph({
    super.key,
    required this.graphRespModel,
    required this.dataKey,
    required this.areaColor,
    // required this.yUnit,
  });

  @override
  State<GasInjectionGraph> createState() => _GasInjectionGraphState();
}

class _GasInjectionGraphState extends State<GasInjectionGraph> {
 

  @override
  void initState() {
   

    super.initState();
  }
String getValueByKey(GraphRespModel data, String key) {
  final map = data.toJson();  
  return map.entries.firstWhere(
    (e) => e.key.toLowerCase() == key.toLowerCase(),
    orElse: () => MapEntry(key, '0'),
  ).value.toString();
}

  @override
  Widget build(BuildContext context) {
    final graphData = widget.graphRespModel;
    log("graphData build dataKey ${widget.dataKey}");

    if (graphData.isEmpty) {
      return Center(child: Text('No data available'));
    }

 

    double minValue = graphData
    .map((e) => double.tryParse(getValueByKey(e, widget.dataKey)) ?? 0)
    .reduce((a, b) => a < b ? a : b);
     double maxValue = graphData
    .map((e) => double.tryParse(getValueByKey(e, widget.dataKey)) ?? 0)
    .reduce((a, b) => a > b ? a : b);
 
    double range = maxValue - minValue;
    bool isSmallRange = maxValue < 1.0;
     if (range == 0) {
      range = isSmallRange ? 0.01 : maxValue / 10;
    }
    double interval;
if (isSmallRange) {
  interval = 0.001;  
} else {
  interval = range / 4;
  if (interval <= 0) interval = 1;
}
 double padding = isSmallRange ? 0.005 : range * 0.2;

double adjustedMin = (minValue - padding).clamp(0, minValue);
double adjustedMax = maxValue + padding;

 
    // double adjustedMax = (maxValue + padding).roundToDouble();

    // double adjustedMin = (minValue - 10).clamp(0, minValue).roundToDouble();
    // double adjustedMax = (maxValue + 10).roundToDouble();
//     if (adjustedMin == adjustedMax) {
//   adjustedMax = adjustedMin + 10;
// }
    return Column(
      children: [
        Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  color: Colors.black,
                  child: Text(
                    getLabel(widget.dataKey),
                    style: txtStylegrey
                  ),
                ),
        SfCartesianChart(
          // zoomPanBehavior: ZoomPanBehavior(enablePanning: true,
          // enablePinching: true,
          // zoomMode: ZoomMode.x,
          // enableDoubleTapZooming: true,
          // // This is the important one:
          // enableSelectionZooming: true,), 
          plotAreaBorderColor: Colors.transparent, 
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            majorGridLines: const MajorGridLines(width: 0),
            interval: 1,
            title: AxisTitle(text: "Time",textStyle: txtStylegrey),
            labelRotation: -70,labelStyle: txtStylegrey,
          ),
          primaryYAxis: NumericAxis(
            minimum: adjustedMin,
            maximum: adjustedMax,
            //  title: AxisTitle(text: "Flow",textStyle: txtStylegrey) ,
            title: AxisTitle(text: getUnit(widget.dataKey), textStyle: txtStylegrey),
        
            majorGridLines: MajorGridLines(width: 0),
            interval: interval,
            numberFormat: NumberFormat("##0.000"),labelStyle: txtStylegrey,
          ), 
          trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
            lineColor: Colors.transparent,
          ),
          series: <CartesianSeries<GraphRespModel, String>>[
            AreaSeries<GraphRespModel, String>(
              dataSource: widget.graphRespModel,
              xValueMapper: (GraphRespModel data, _) {
                // log("xValueMapper $data");
                // log("xValueMapper ${data.timeStamp}");
        
                return data.timeStamp.toString();
              },
              yValueMapper: (GraphRespModel data, _) {
                // log("xValueMapper yyyy $data");
                // log("xValueMapper yyy ${data.flow.toString()}");
                // return double.parse(data.flow.toString());
                return double.tryParse(getValueByKey(data, widget.dataKey)) ?? 0;
              },
              
              color: widget.areaColor.withOpacity(0.65), 
              markerSettings: MarkerSettings(
                isVisible: true,
                width: 4,
                height: 4,
                borderColor: widget.areaColor,
                shape: DataMarkerType.circle,
              ),
            ),
          ],
           
        ),
      ],
    );
  }

Map<String, Map<String, String>> dataLabels = {
  'FedGas_C_Four': {
    'label': 'C2/C4',
    'unit': 'Percentage',
  },
  'Plant_Load_Percentage': {
    'label': 'Load',
    'unit': 'Percentage',
  },
  'FedGas_Volume': {
    'label': 'Inlet',
    'unit': 'KSCMH',
  },
  'FedGas_PR': {
    'label': 'Flow',
    'unit': 'Kg/cm²',
  },
};
String getLabel(String key) {
  return dataLabels[key]?['label'] ?? 'NA';
}

String getUnit(String key) {
  return dataLabels[key]?['unit'] ?? '';
}
}
