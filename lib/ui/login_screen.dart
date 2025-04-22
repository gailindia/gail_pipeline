// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_field, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gail_pipeline/widgets/dialog_with_timer.dart';
import 'package:gail_pipeline/widgets/loadingview.dart';
 
import 'package:get/get.dart';

import 'package:secure_shared_preferences/secure_shared_pref.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final PRMSServices _prmsServices = Get.put(PRMSServices());
  final _formKey = GlobalKey<FormState>();
  bool numbervisible = true;
  bool otpvisible = false;
  int secondsRemaining = 45;
  bool enableResend = false;
  Timer? timer;
  String? otp = "", roletype = '';
  List<String> role = [
    'Permit Receiver',
    'Permit Issuer',
    'F&S Authorization',
    'In-Charge'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: _height,
            width: _width,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/splashicon2.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: otpvisible,
                      child: InkWell(
                        onTap: () {
                          if (otpvisible == true) {
                            otpvisible = false;
                            numbervisible = true;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 150.0),
                        child: Container(
                          width: 150,
                          height: 100,
                          child: Image.asset("assets/images/gail_logo.png"),
                        ),
                      ),
                      Visibility(
                        visible: numbervisible,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 30, right: 30, bottom: 4),
                                child: TextFormField(
                                  minLines: 1,
                                  autocorrect: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: userIDController,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    cut: false,
                                    paste: false,
                                    selectAll: false,
                                  ),
                                  textCapitalization:
                                  TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? "Kindly Enter UserID"
                                      : null,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // ignore: prefer_const_constructors
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    labelText: "User ID",
                                    prefixIcon:
                                    Icon(Icons.person_outline_rounded),
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.indigo),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.indigo),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 30, right: 30, bottom: 4),
                                child: TextFormField(
                                  minLines: 1,
                                  autocorrect: false,
                                  obscureText:true,
                                  keyboardType: TextInputType.multiline,
                                  controller: passwordController,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    cut: false,
                                    paste: false,
                                    selectAll: false,
                                  ),
                                  textCapitalization:
                                  TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? "Password"
                                      : null,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // ignore: prefer_const_constructors
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    labelText: "Password",
                                    prefixIcon:
                                    Icon(Icons.person_outline_rounded),
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.indigo),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.indigo),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      loginMethod("login", context);
                                    }
                                  },
                                  child: Text("Login"))
                            ],
                          ),
                        ),
                      ),
    
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void loginMethod(String type, BuildContext context) async {
    LoadingDialog.show(context);
    SecureSharedPref sharedPreferences = await SecureSharedPref.getInstance();
    String? response;
    Map<String, String>? _body;
    // String role  = roletype == "In-Charge" ? "CGD In-Charge" : roletype.toString();
    _body = {
      "userid": userIDController.text,
      "password": passwordController.text
    };
    // response = await _prmsServices.loginAPI(_body);
    // print("RESPONSE FROM LOGIN API :: $response");
    if (response == "Login Successfully") {
      LoadingDialog.hide(context);
      DialogUtilsTimer.showCustomDialog(context,
          title: "Success", description: response.toString(), onPressed: () {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       // MaterialPageRoute(builder: (context) => HomeScreen()),
          //       MaterialPageRoute(builder: (context) => CGDPermitApp(name: 'INJT',)),
          //       ModalRoute.withName("/CGD"));
          });
    } else {
      LoadingDialog.hide(context);
      DialogUtilsTimer.showCustomDialog(context,
          title: "Error", description: response.toString(), onPressed: () {
            // Navigator.of(context).pop();
            setState(() {});
          });
    }
  }


  @override
  dispose() {
    super.dispose();
  }
}
