  import 'package:flutter/material.dart';
import 'package:gail_pipeline/utils/secure_storage.dart';
import 'package:gail_pipeline/widgets/styles/mytextStyle.dart';
import 'package:get/get.dart';

void logout(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Color(0xff282824), 
        content: const Text('Are you sure you want to logout?',style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                   color: Color(0xffBE2023),
                  
                ),
                // height: 50,
                child:   Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('NO',style: txtStyleWhite,)),
                )),
          ),
          // const Spacer(),
          TextButton(
            onPressed: () async {
               await LocalStorage.localStorage.deleteAll();

               Get.offAllNamed('/loginScreen');
            },
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xffBE2023),
                borderRadius: BorderRadius.circular(10.0),
                 
              ),
              child:   Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'YES',
                 style: txtStyleWhite
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
