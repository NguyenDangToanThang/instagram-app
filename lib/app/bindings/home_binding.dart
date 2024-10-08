import 'package:get/get.dart';
import 'package:insta/app/controllers/follow_controller.dart';
import 'package:insta/app/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FollowController());
  }
}
