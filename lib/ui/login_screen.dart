 

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart'; 
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/controller/login_controller.dart';
import 'package:gail_pipeline/utils/secure_storage.dart'; 
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';

import 'package:get/get.dart';

 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController()); 
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
    fetchSecureStorageData();  
    super.initState();
  }
  
Future<void> fetchSecureStorageData() async {
loginController.userIDController.text = await LocalStorage.getUserName() ?? "";
loginController.passwordController.text = await LocalStorage.getPassWord() ?? "";
 if (loginController.userIDController.text.isNotEmpty && loginController.passwordController.text.isNotEmpty) { 
      loginController.loginUser(); 
    } 
}

  @override
  Widget build(BuildContext context) {
    // fetchSecureStorageData(); 
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [ 
                  Padding(
                    padding: EdgeInsets.only(top: 50.0, bottom: 50),
                    child: Image.asset(
                      kIconLogo,
                      height: 80,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xff37322D),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            minLines: 1,
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            controller: loginController.userIDController,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 30,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'User Id is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              counterText: '',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              hintText: "Username",
                              hintStyle: txtStylegrey,
                              // prefixIcon: Icon(Icons.person_outline_rounded),
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.indigo,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
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
                        SizedBox(height: 15),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            minLines: 1,
                            autocorrect: false,
                            obscureText: true,
                            keyboardType: TextInputType.multiline,
                            controller: loginController.passwordController,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 20,
                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              counterText: '',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: txtStylegrey,
                              //  prefixIcon: Icon(Icons.person_outline_rounded),
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.indigo,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
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

                        SizedBox(height: 25),
                        InkWell(
                          onTap: () { 
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              log("call login");

                              loginController.loginUser();
                            }
                          },

                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffBE2023),
                              borderRadius: BorderRadius.circular(8),
                            ),

                            child: Text(
                              "Login".toUpperCase(),
                              style: txtStyleWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
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
