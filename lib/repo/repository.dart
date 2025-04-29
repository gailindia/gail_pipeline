import 'dart:async';

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/model/gasStation_respModel.dart';
import 'package:gail_pipeline/model/getGasData_respModel.dart';
import 'package:gail_pipeline/model/login_respModel.dart';

import 'package:get/get.dart';

class APIService extends GetConnect {
  //   ///////////////********************* send error logs ****************///////////////////////
  //   sendErrorLogs({
  //     required String apiName,
  //     required int statusCode,
  //     required String className,
  //     required String message,
  //   }) async {
  //     // String? cpfNumber = await LocalSharedPrefs.instance.prefs.getString("cpfNumber", isEncrypted: true);

  //     try {
  //       final body = {
  //         "ApiName": apiName,
  //         "Message": message,
  //         "ClassName": className,
  //         "StatusCode": statusCode,
  //       };

  //       // final response = await httpClient.post(kSendErrorLogsApi, body: body);
  //     } catch (e, s) {
  //       handleException(
  //         exception: e,
  //         stackTrace: s,
  //         exceptionClass: _tag,
  //         exceptionMsg: 'exception while sending error logs to server',
  //       );
  //     }
  //   }

  //   ///////////////********************* send error logs ****************///////////////////////

  ////////////////********************* login ****************///////////////////////
  Future<LoginResModel?> loginRepo({
    required String userId,
    required String password,
  }) async {
    var data = {"userid": userId, "password": password};

    final response = await post(
      baseUrl + loginUrl,
      data,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    log("code ${response.statusCode} $HttpStatus");
    if (response.statusCode == 200) {
      final List<dynamic> decodedBody = response.body;
      final firstItem = decodedBody[0]; // Access first item in the list

      final loginModel = LoginResModel.fromJson(firstItem);
      log("LoginResModel $loginModel");

      return loginModel;
    } else {
      return null;
    }
  }

  ////////////***************************GetGasData*******************///////////////////////////

  Future<List<GetGasDataRespModel>?> getGasDataRepo() async {
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IklxbVFzZU5pSU9xeEExdzBLbEpQM3c9PSIsIm5iZiI6MTc0NTU2Mzg1MiwiZXhwIjoxNzQ2ODU5ODUyLCJpYXQiOjE3NDU1NjM4NTJ9.uNcJQbLtCT43tc889KUYtuF9zEDBEchDn3jCI5WH1Z4";
    // String? token = await LocalSharedPrefs.instance.prefs.getString("token", isEncrypted: true);

    final response = await get(
      baseUrl + getGasDataUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    log("code ${response.statusCode} $HttpStatus");
    if (response.statusCode == 200) {
      final List<dynamic> gasList = response.body;
      final List<GetGasDataRespModel> gasDataModels =
          gasList.map((item) => GetGasDataRespModel.fromJson(item)).toList();

      // log("Gas data list: $gasDataModels");
      return gasDataModels;
    } else {
      Get.defaultDialog(
        middleText: response.statusText.toString(),
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          // isApiCalling(false);
          // update();
        },
      );

      return null;
    }
  }
  ////////////******************GetGasStationData*******************///////////////////////////

  Future<List<GetGasStationRespModel>?> gasStationRepo() async {
    String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IklxbVFzZU5pSU9xeEExdzBLbEpQM3c9PSIsIm5iZiI6MTc0NTU2Mzg1MiwiZXhwIjoxNzQ2ODU5ODUyLCJpYXQiOjE3NDU1NjM4NTJ9.uNcJQbLtCT43tc889KUYtuF9zEDBEchDn3jCI5WH1Z4";
    final response = await get(
      baseUrl + getGasStationUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    log("code ${response.statusCode} $HttpStatus");
    if (response.statusCode == 200) {
     final List<dynamic> gasList = response.body;
      final List<GetGasStationRespModel> gasStationModels =
          gasList.map((item) => GetGasStationRespModel.fromJson(item)).toList();

      // log("Gas data list: $gasStationModels");
      return gasStationModels;
    } else {
      Get.defaultDialog(
        middleText: response.statusText.toString(),
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          // isApiCalling(false);
          // update();
        },
      );

      return null;
    }
  }
}
