import 'package:get/get.dart';
import 'package:insta/app/controllers/like_controller.dart';

class LikeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LikeController());
  }
}
