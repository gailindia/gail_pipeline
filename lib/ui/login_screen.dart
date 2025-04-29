// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_field, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/controller/login_controller.dart';
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
  LoginController loginController = Get.put(LoginController());
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
    'In-Charge',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Image.asset(
                      kIconLogo,
                      height: 100,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 30,
                      right: 30,
                      bottom: 4,
                    ),
                    child: TextFormField(
                      minLines: 1,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      controller: loginController.userIDController,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User Id is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        labelText: "User ID",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.indigo,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 30,
                      right: 30,
                      bottom: 4,
                    ),
                    child: TextFormField(
                      minLines: 1,
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.multiline,
                      controller: loginController.passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // ignore: prefer_const_constructors
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.indigo,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Get.offAllNamed('/homeScreen');
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        log("call login");

                        loginController.loginUser();
                      }
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
