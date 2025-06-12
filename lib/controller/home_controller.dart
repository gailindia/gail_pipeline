import 'dart:developer';
import 'dart:io';

 
import 'package:flutter/cupertino.dart';
import 'package:gail_pipeline/model/gasStation_respModel.dart';
import 'package:gail_pipeline/model/getGasData_respModel.dart';
import 'package:gail_pipeline/model/graph_respModel.dart';
import 'package:gail_pipeline/repo/repository.dart';
import 'package:gail_pipeline/utils/common_loader.dart'; 
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/secure_storage.dart';
import '../widgets/dialog.dart';

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


    @override
    void onInit(){
    super.onInit();
    getAppVersion();
    update();
    }


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
    CommonLoader.showLoading();
    getGraphRespModel.value =  await apiService.getGraphDataRepo(type: type.value.trim(),region:region.value.trim(),name: name.value.trim()) ?? [];
    log("getGraphRespModel controller ${getGraphRespModel.length}");
    CommonLoader.hideLoading();
    // getGraphRespModel =  await apiService.getGraphDataRepo(type.value.toUpperCase(),region.value.toUpperCase(),name.value.toUpperCase());
  }

  getAppVersion() async {
    late String _storeLink, _serverAppVersion;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // calling get app version method
    String currentAppVersion =packageInfo.version;
    // update([kAppVersion]);

    if (Platform.isAndroid) {
      _storeLink = 'https://play.google.com/store/apps/details?id=com.gail.gailprms';
      _serverAppVersion = (await LocalStorage.getApkVersion())??"";
    } else if (Platform.isIOS) {
      _storeLink = 'https://apps.apple.com/in/app/prms/id1574884477';
      _serverAppVersion = (await LocalStorage.getIpaVersion())??"";


    }

    print("currentAppVersion :; $currentAppVersion");
    // currentAppVersion = "3.5";
    final int _serverAppVer = int.parse(_serverAppVersion.replaceAll('.', ''));
    final int _currentAppVer =
    int.parse(currentAppVersion!.replaceAll('.', ''));

    if (_serverAppVer > _currentAppVer) {
      // calling update app dialog method
      updateAppDialog(context : Get.context!, storeLink: _storeLink);
    }
  }

}