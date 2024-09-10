import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Center(
      child: InkWell(
          onTap: () {
            homeController.logout();
          },
          child: const Text("Setting View")),
    );
  }
}
