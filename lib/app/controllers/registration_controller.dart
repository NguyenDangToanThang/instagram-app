import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/repositories/auth_repository.dart';
import 'package:insta/config/route/routes.dart';

class RegistrationController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKeyRegistration = GlobalKey<FormState>();
  RxBool loading = false.obs;

  Future<void> register() async {
    loading.value = true;
    Map data = {
      'fullname': fullnameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim()
    };
    try {
      await authRepository.registerAPI(data);
      fullnameController.clear();
      emailController.clear();
      passwordController.clear();
      loading.value = false;
      Get.offAndToNamed(Routes.loginScreen);
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
