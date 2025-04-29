import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  static final DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String description,
    String okBtnText = "Ok",
    String cancelBtnText = "Cancel",
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: <Widget>[
                //  ElevatedButton(
                //   child: Text(okBtnText),
                //   onPressed: okBtnFunction,
                // ),
                ElevatedButton(
                    child: Text(okBtnText),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          });
        });
  }
}
showToastMessage({required String title, required String message}) {
  Get.snackbar(title, message, duration: const Duration(seconds: 20),colorText: Color(0xffFF001A));
}
