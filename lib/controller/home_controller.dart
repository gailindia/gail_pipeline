import 'dart:developer';

 
import 'package:gail_pipeline/model/gasStation_respModel.dart';
import 'package:gail_pipeline/model/getGasData_respModel.dart';
import 'package:gail_pipeline/model/graph_respModel.dart';
import 'package:gail_pipeline/repo/repository.dart';
import 'package:gail_pipeline/utils/common_loader.dart'; 
import 'package:get/get.dart';

class HomeController extends GetxController{
   final APIService apiService = Get.put(APIService());
     RxBool isLoading = true.obs;
   
    RxString syncDate = "".obs;
    RxList<GetGasStationRespModel> getGasStationRespModel = <GetGasStationRespModel>[].obs; 
    List<GetGasDataRespModel>? getGasDataRespModel;
    RxList<GraphRespModel> getGraphRespModel = <GraphRespModel>[].obs;
    RxString type = "".obs;
    RxString name = "".obs;
    RxString region = "".obs;



////////////////////////////gas data /////////////////////////////////////
   Future<void> getGasDataApi() async{
    // CommonLoader.showLoading();

      getGasDataRespModel = await apiService.getGasDataRepo();
      log("getGasDataApi ***** ${getGasDataRespModel?.length ?? 0}");
    
  }
  
   ///////////************* gas station data  ****//////////////////////////////

   Future<void> getGasStaionApi() async{
    isLoading.value = true;
    try {
      getGasStationRespModel.value = await apiService.gasStationRepo()?? []; 
       syncDate.value = getGasStationRespModel[0].timeStamp ?? ""; 
       isLoading.value = false;
        log("getGasStaionApi ***** ${syncDate.value}"); 
      
    } catch (e) {
      isLoading.value = false;
      log("getGasStaionApi catch $e");
      
    } 
  } 

  ///////////************* graph data  ****//////////////////////////////
  Future<void> getGraphApi() async{
    getGraphRespModel.value =  await apiService.getGraphDataRepo(type: type.value.trim(),region:region.value.trim(),name: name.value.trim()) ?? [];
    log("getGraphRespModel controller ${getGraphRespModel?.length}");
    // getGraphRespModel =  await apiService.getGraphDataRepo(type.value.toUpperCase(),region.value.toUpperCase(),name.value.toUpperCase());
  }
}