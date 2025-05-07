import 'dart:developer';

import 'package:flutter/material.dart'; 
import 'package:gail_pipeline/repo/repository.dart';
import 'package:gail_pipeline/utils/common_loader.dart';
import 'package:gail_pipeline/utils/secure_storage.dart'; 
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
   final APIService apiService = Get.put(APIService());

   Future<void> loginUser() async{
    CommonLoader.showLoading();
    try{
    final res = await apiService.loginRepo(userId: userIDController.text.trim(),password: passwordController.text.trim());
      
    if (res != null && res.response == true) {
      log("==-=-=${res.message }");
      CommonLoader.hideLoading();
      LocalStorage.setUserDetails(userIDController.text.trim(),passwordController.text.trim()); 
      Get.offAllNamed("/homeScreen");
    }
       else {
        CommonLoader.hideLoading();
        log("else ****==-=-=${res!.message}");
        Get.defaultDialog(
              middleText: res.message.toString(),
              textConfirm: 'OK',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                // isApiCalling(false);
                update();
              });
      }
    } catch (e) {
  CommonLoader.hideLoading();
  log("Login error: $e");

  Get.defaultDialog(
    middleText: "Something went wrong. ",
    textConfirm: 'OK',
    confirmTextColor: Colors.white,
    onConfirm: () => Get.back(),
  );
    }
    
    // try {
    //     // await showProgressDialog(context);
    //   log("loginUser");
    //   // if (await checkConnectivity()) {
       
          
    //   EndPointRepsitory repsitory =
    //       EndPointRepsitory(client: client.init());
    //   repsitory.loginRepo(userId: userIDController.text.trim(),password: passwordController.text.trim(),
    //     );

    //   //  final result = await EndPointRepsitory.to
    //   //       .loginRepo(userId: userIDController.text.trim(), password: passwordController.text.trim());
        
    //     log("result****** controller $repsitory");
 
    //   // } else { 
    //   // }

    //   // // calling hide progress dialog method
    //   // await hideProgressDialog();
   
   
    //   //   Get.dialog(buildLoadingIndicator());
    //   //   final params =
    //   //       LoginParams(phone: int.tryParse(phone.text), password: password.text);
    //   //   final response = await repository.loginUser(params);
    //   //   Get.back();
    //   //   if (response.data != null) {
    //   //     // showToastMessage(
    //   //     //   title: "Success",
    //   //     //   message: "Login Successful",
    //   //     // );
    //   //     LocalStorage.saveToken((response.data?.token)!);
    //   //     Get.offAll(() => MyDashBoard());
    //   //   }
    // } catch (error) {
    //   log(error.toString());
    // }
  }

  
  //   loginMethod( BuildContext context) async {
  //   LoadingDialog.show(context);
  //   SecureSharedPref sharedPreferences = await SecureSharedPref.getInstance();
  //   String? response;
  //   Map<String, String>? _body;
  //   // String role  = roletype == "In-Charge" ? "CGD In-Charge" : roletype.toString();
  //   _body = {
  //     "userid": loginController.userIDController.text,
  //     "password": loginController.passwordController.text
  //   };
  //   // response = await _prmsServices.loginAPI(_body);
  //   // print("RESPONSE FROM LOGIN API :: $response");
  //   if (response == "Login Successfully") {
  //     LoadingDialog.hide(context);
  //     DialogUtilsTimer.showCustomDialog(context,
  //         title: "Success", description: response.toString(), onPressed: () {
  //         //   Navigator.pushAndRemoveUntil(
  //         //       context,
  //         //       // MaterialPageRoute(builder: (context) => HomeScreen()),
  //         //       MaterialPageRoute(builder: (context) => CGDPermitApp(name: 'INJT',)),
  //         //       ModalRoute.withName("/CGD"));
  //         });
  //   } else {
  //     LoadingDialog.hide(context);
  //     DialogUtilsTimer.showCustomDialog(context,
  //         title: "Error", description: response.toString(), onPressed: () {
  //           // Navigator.of(context).pop();
  //           setState(() {});
  //         });
  //   }
  // }


 
}