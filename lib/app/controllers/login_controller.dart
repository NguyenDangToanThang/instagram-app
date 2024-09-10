import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:insta/app/repositories/auth_repository.dart';
import 'package:insta/config/instants.dart';
import 'package:insta/config/route/routes.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKeyLogin = GlobalKey<FormState>();
  RxBool loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    emailController.text = await storage.read(key: "email") ?? "";
    String checkToken = await authRepository.checkToken();
    if (checkToken.contains(Instants.tokenValid)) {
      Get.offAndToNamed(Routes.homeScreen);
    }
  }

  Future<void> login() async {
    loading.value = true;
    Map data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim()
    };
    try {
      String? token = await authRepository.loginAPI(data);
      if (token != null) {
        emailController.clear();
        passwordController.clear();
        Get.offAndToNamed(Routes.homeScreen);
        loading.value = false;
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text("Failed"),
                contentPadding: EdgeInsets.all(20),
                children: [Text("Đăng nhập thất bại")],
              );
            });
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
