import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gail_pipeline/repo/repository.dart';

Future<bool> checkConnectivity() async {
  try {
    final _connectivityResult = await Connectivity().checkConnectivity();

    if (_connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (_connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  } catch (e, s) {
    log("e,s $e **** $s");
    handleException(
      exception: e,
      stackTrace: s,
      exceptionClass: 'utils',
      exceptionMsg: 'exception while checking for connectivity',
    );

    return false;
  }
}
handleException({
  String apiName = '',
  int statusCode = 400,
  required exception,
  required stackTrace,
  required String exceptionClass,
  required String exceptionMsg,
}) async {
  // FirebaseCrashlytics.instance.log('$exceptionClass: $exceptionMsg');

  // FirebaseCrashlytics.instance.recordError(
  //   exception,
  //   stackTrace,
  //   printDetails: true,
  //   reason: '$exceptionClass: $exceptionMsg',
  // );

  if (await checkConnectivity() && apiName.isNotEmpty) {
    // calling send error logs method
    // EndPointRepsitory.sendErrorLogs(
    //   apiName: apiName,
    //   statusCode: statusCode,
    //   className: exceptionClass,
    //   message:
    //       '$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace',
    // );
  }
}