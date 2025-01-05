import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/screens/auth/widgets/button_normal.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Center(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(() {
                        if (homeController.user.value == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeController.user.value!.fullname,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 26),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              homeController.user.value!.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            homeController.user.value!.bio != null
                                ? const SizedBox(height: 4.0)
                                : const SizedBox.shrink(),
                            homeController.user.value!.bio != null
                                ? Text(
                                    "Tiểu sử: ${homeController.user.value!.bio}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
                      }),
                    ),
                    Expanded(
                        flex: 1,
                        child: Obx(() {
                          if (homeController.user.value!.avatar == null) {
                            return const Center(
                                child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/avatar.jpg"),
                            ));
                          }
                          return Center(
                              child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                homeController.user.value!.avatar!),
                          ));
                        }))
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  return Text(
                    "${homeController.user.value!.follower} người theo dõi",
                    style: const TextStyle(color: Colors.white60),
                  );
                }),
                const SizedBox(height: 8),
                ButtonNormal(
                    title: "Đăng xuất", onPress: () => homeController.logout())
              ],
            ),
          )),
    );
  }
}
