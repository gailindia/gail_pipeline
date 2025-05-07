import 'package:gail_pipeline/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true); // or without permanent, if needed
  }
}