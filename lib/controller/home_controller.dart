import 'dart:developer';

 
import 'package:gail_pipeline/model/gasStation_respModel.dart';
import 'package:gail_pipeline/model/getGasData_respModel.dart';
import 'package:gail_pipeline/repo/repository.dart'; 
import 'package:get/get.dart';

class HomeController extends GetxController{
   final APIService apiService = Get.put(APIService());
   
   RxString syncDate = "".obs;
    List<GetGasStationRespModel>? getGasStationRespModel; 
    List<GetGasDataRespModel>? getGasDataRespModel;

   Future<void> getGasDataApi() async{
    // CommonLoader.showLoading();

      getGasDataRespModel = await apiService.getGasDataRepo();
      log("getGasDataApi ***** ${getGasDataRespModel?.length ?? 0}");
    
  }


   Future<void> getGasStaionApi() async{
    // CommonLoader.showLoading();

      getGasStationRespModel = await apiService.gasStationRepo();
     
       syncDate.value = getGasStationRespModel?[0].timeStamp ?? ""; 
        log("getGasStaionApi ***** ${syncDate.value}"); 
   
  }
}