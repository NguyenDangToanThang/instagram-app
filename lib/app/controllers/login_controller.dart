import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/repositories/auth_repository.dart';
import 'package:insta/config/route/routes.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKeyLogin = GlobalKey<FormState>();
  RxBool loading = false.obs;

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

        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text("Success"),
                contentPadding: EdgeInsets.all(20),
                children: [Text("Đăng nhập thành công")],
              );
            });
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
