import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/screens/auth/widgets/button_auth.dart';

class UpPostView extends StatefulWidget {
  const UpPostView({super.key});

  @override
  State<UpPostView> createState() => _UpPostViewState();
}

class _UpPostViewState extends State<UpPostView> {
  final HomeController postController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(() {
            return postController.image.value == null
                ? TextButton.icon(
                    onPressed: postController.takePicture,
                    icon: const Icon(Icons.camera),
                    label: const Text("Chụp ảnh"),
                  )
                : Column(
                    children: [
                      Image.file(
                        postController.image.value!,
                        scale: 1.0,
                        height: 200,
                        width: 200,
                      ),
                      TextButton.icon(
                        onPressed: postController.takePicture,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Chụp lại"),
                      ),
                    ],
                  );
          }),
          const SizedBox(height: 6),
          TextField(
            controller: postController.captionController,
            decoration: const InputDecoration(
              labelText: "Nhập chú thích",
            ),
          ),
          const SizedBox(height: 6),
          ButtonAuth(
              title: "Đăng bài",
              onPress: () {
                postController.createPost();
              })
        ],
      ),
    );
  }
}
