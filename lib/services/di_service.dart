import 'package:get/get.dart';
import 'package:sokketnetwork/controllers/home_controller.dart';
import 'package:sokketnetwork/controllers/main_controller.dart';

class DIService {
  static Future<void> init() async {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
