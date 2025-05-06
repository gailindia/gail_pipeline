

import 'dart:async';
import 'dart:developer';
 

import 'package:flutter/material.dart'; 
import 'package:gail_pipeline/constants/app_constants.dart';
import 'package:gail_pipeline/utils/secure_storage.dart'; 
import 'package:gail_pipeline/widgets/logowidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; 


 
 


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key,});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> { 

  @override
  void initState() { 
    super.initState();
    _navigateToNextScreen();
  
      Timer(
        const Duration(seconds: 5),
            () =>
                // Get.toNamed('/homeScreen')
                Get.toNamed('/loginScreen')

    );

   

    // _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {  
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(height: 120,),
              SizedBox(height: 12),
              Column(
                children: [
                  Center(
                    child: Text(
                      kAppName,
                      maxLines: 2,
                      style: GoogleFonts.hind(
                        textStyle: Theme.of(context).textTheme.headlineMedium,
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      kWorkPermit,
                      maxLines: 2,
                      style: GoogleFonts.hind(
                        textStyle: Theme.of(context).textTheme.headlineMedium,
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      kAppNamelast,
                      maxLines: 2,
                      style: GoogleFonts.hind(
                        textStyle: Theme.of(context).textTheme.headlineMedium,
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ), //style: textStyle24Bold),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToNextScreen() async {

    // debugPrint('fcm token is: ${SharedPrefs.to.fcmToken}');
   try{
 
     String? userID = await LocalStorage.getToken() ?? "";
     log("token splash $userID");

     await Future.delayed(const Duration(seconds: 3));
     // ignore: use_build_context_synchronously
     if (userID == null) {
       // ignore: use_build_context_synchronously
      //  Navigator.pushReplacement(context,
      //      MaterialPageRoute(builder: (context) => const LoginScreen()));
     } else {
       // ignore: use_build_context_synchronously
      //  Navigator.pushReplacement(context,
      //      // MaterialPageRoute(builder: (context) => const HomeScreen()));
      //      MaterialPageRoute(builder: (context) => const CGDPermitApp(name:"INJT")));
     }
   }catch(e){

   }
   }

  // void getAppVersion() async {
  //   String? response;
  //   response = await _prmsServices.getversionData();
  //   if (response == "succuss") {

  //   } else {

  //   }


  //   setState(() {});
  //   if (this.mounted) {}
  //   // _prefs.setString(
  //   //       "APK_VERSION", _response.body["APK_INFO"][0]["APK_VERSION"]);
  //   //   _prefs.setString(
  //   //       "IPA_VERSION", _response.body["APK_INFO"][0]["IPA_VERSION"]);
  // }
}
