import 'package:flutter/material.dart';
import 'package:gail_pipeline/routes/my_router.dart'; 
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'GAIL Pipeline Live',
      color: Colors.indigo,
        initialRoute: '/',
        getPages: MyRouter.route 

 
 
    );
  }
}
 