import 'dart:async';

import 'package:flutter/material.dart';

class DialogUtilsTimer {
  static final DialogUtilsTimer _instance = new DialogUtilsTimer.internal();

  DialogUtilsTimer.internal();

  factory DialogUtilsTimer() => _instance;
  Timer? timer;
  int secondsRemaining = 30;
  bool enableResend = false;
  static void showCustomDialog(BuildContext context, {
    required String title,
    required String description,
    String okBtnText = "Ok",
    String cancelBtnText = "Cancel",
    required VoidCallback onPressed,
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
            Navigator.of(context).pop();
            onPressed();
            })
            ]);
          });
        });
  }

}
