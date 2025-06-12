import 'package:flutter/material.dart';
import 'package:gail_pipeline/widgets/primary_button.dart';
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
  Get.snackbar(title, message, duration: const Duration(seconds: 3),colorText: Color(0xffFF001A));
}


updateAppDialog({required BuildContext context, required String storeLink}) {
  return showGeneralDialog(
    context: Get.context!,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 400),

    pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
        _CustomDialog(storeLink: storeLink),
  );
}

class _CustomDialog extends StatelessWidget {
  final String storeLink;

  const _CustomDialog({required this.storeLink});

  @override
  Widget build(BuildContext context) {//colorController.
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(
                  top: 24, left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Update App',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w600,
                      ), textAlign: TextAlign.center),

                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text('Please update the latest version of PRMS!',
                        style: TextStyle(fontSize: 16, letterSpacing: 0.55, color: Color(0xFF555555))),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      btnColor: Colors.indigo,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      btnTextStyle:
                      TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w600,
                      ).copyWith(color: Colors.white),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Ok',
                      btnColor: Colors.indigo,
                      btnTextStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () async {
                        // calling launch method
                        ///TODO Need to check url launcher
                        // await launch(storeLink);
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
