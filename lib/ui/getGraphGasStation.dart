import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;


class GetGraphGasStation extends StatefulWidget {
  final String? seqno;
  const GetGraphGasStation({Key? key, required this.seqno}) : super(key: key);



  @override
  State<GetGraphGasStation> createState() => _GetGraphGasStationState();
}

class _GetGraphGasStationState extends State<GetGraphGasStation> {
  // GetGraphGasStationController getGraphGasStationController = Get.put(GetGraphGasStationController());
  // Model model =Model();
  // List<MainDataModel>? mainDataModel=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getGraphGasStationController.getGasStationDataApi(widget.seqno);
    callApi();

  }
  callApi() async {
    // LoadingDialog.show(context);
    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    String? token = await prefs.getString('token',isEncrypted: true);
    var res = await http.get(Uri.parse("https://gailebank.gail.co.in/GAIL_APIs/api/Universal/GetGasStationDataByHourWise"), headers: {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer $token'
    });

    if (res.statusCode == 200) {
      // model=Model.fromJson(jsonDecode(res.body));
      // for(int i = 0; i< model.mainDataList.length; i++){
      //   if(model.mainDataList[i].name == widget.seqno){
      //     mainDataModel!.add(model.mainDataList[i]);
      //   }
      // }

      setState(() {
      });
    }
    // LoadingDialog.hide(context);
  }






  @override
  Widget build(BuildContext context) {
    return Container();
    //  GetBuilder<GetGraphGasStationController>(
        // id: kGraphgasStation,
        // init: GetGraphGasStationController(),
        // builder: (GetGraphGasStationController controller) => Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.blue,
        //   ),
        //     body: controller.isLoading ? Center(child: CircularProgressIndicator(
        //       backgroundColor: Colors.blue,

        //     )):
        //     SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 100,
        //           ),
        //           Container(
        //               height: 300,
        //               child: SfCartesianChart(
        //                 // Initialize category axis
        //                   primaryXAxis: CategoryAxis(
        //                     // intervalType: DateTimeIntervalType.minutes,
        //                     // interval: 5,
        //                   ),
        //                   primaryYAxis: NumericAxis(
        //                     // Setting the interval for Y-axis
        //                     // interval: 15,
        //                     // Setting the minimum and maximum values for Y-axis
        //                     // minimum: 0,
        //                     // maximum: 50,
        //                   ),
              
        //                   series: <LineSeries<SalesData, dynamic>>[
              
        //                     // LineSeries<SalesData, dynamic>(
        //                     //   // Bind data source
        //                     //     dataSource:  <SalesData>[
        //                     //       // SalesData(controller.gas_station_data_list1[index].timeStamp, 28)),
              
        //                     //       for (var item in mainDataModel!)
              
        //                     //         SalesData(item.timeStamp!, double.parse(item.flow!)),
              
        //                     //         // SalesData(item.timeStamp, double.parse(item.flow)),
              
        //                     //                      // SalesData('Mar', 34),
              
        //                     //       // SalesData('May', 40)
        //                     //     ],
        //                     //     xValueMapper: (SalesData sales, _) => sales.year,
        //                     //     yValueMapper: (SalesData sales, _) => sales.sales
        //                     // )
        //                   ]
        //               )
        //           ),
        //           SizedBox(
        //             height: 100,
        //           ),
        //           Container(
        //               height: 300,
        //               child: SfCartesianChart(
        //                 // Initialize category axis
        //                   primaryXAxis: CategoryAxis(
        //                     // intervalType: DateTimeIntervalType.minutes,
        //                     // interval: 5,
        //                   ),
        //                   primaryYAxis: NumericAxis(
        //                     // Setting the interval for Y-axis
        //                     // interval: 15,
        //                     // Setting the minimum and maximum values for Y-axis
        //                     // minimum: 0,
        //                     // maximum: 50,
        //                   ),
        //                   series: <LineSeries<SalesData, dynamic>>[
        //                     LineSeries<SalesData, dynamic>(
        //                       // Bind data source
        //                         dataSource:  <SalesData>[
        //                           // SalesData(controller.gas_station_data_list1[index].timeStamp, 28)),
              
        //                           // for (var item in mainDataModel!)
              
        //                             // SalesData(item.timeStamp!, double.parse(item.inlet!)),
              
        //                           // SalesData(item.timeStamp, double.parse(item.flow)),
              
        //                           // SalesData('Mar', 34),
              
        //                           // SalesData('May', 40)
        //                         ],
        //                         xValueMapper: (SalesData sales, _) => sales.year,
        //                         yValueMapper: (SalesData sales, _) => sales.sales
        //                     )
        //                   ]
        //               )
        //           ),
        //         ],
        //       ),
        //     ),

            // ListView.builder(
            //     itemCount: controller.gas_station_data_list1.length,
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) {
            //     return Container(
            //         height: 300,
            //         child: SfCartesianChart(
            //           // Initialize category axis
            //             primaryXAxis: CategoryAxis(),
            //
            //             series: <LineSeries<SalesData, dynamic>>[
            //               LineSeries<SalesData, dynamic>(
            //                 // Bind data source
            //                   dataSource:  <SalesData>[
            //                     // SalesData(controller.gas_station_data_list1[index].timeStamp, 28)),
            //                     SalesData(controller.gas_station_data_list1[index].timeStamp, double.parse(controller.gas_station_data_list1[index].flow)),
            //                     // SalesData('Mar', 34),
            //                     // SalesData('Apr', 32),
            //                     // SalesData('May', 40)
            //                   ],
            //                   xValueMapper: (SalesData sales, _) => sales.year,
            //                   yValueMapper: (SalesData sales, _) => sales.sales
            //               )
            //             ]
            //         )
            //     );
            //   }
            // )
        // ));




  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
