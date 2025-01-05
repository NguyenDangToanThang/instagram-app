import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/screens/auth/widgets/button_normal.dart';

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
                ? const SizedBox.shrink()
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
                labelText: "Nhập chú thích", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.picture_in_picture_outlined,
                    color: Colors.white60,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () async => postController.takePicture(),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white60,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Obx(() {
            return ButtonNormal(
                title: "Đăng bài",
                loading: postController.loadingPost.value,
                onPress: () {
                  postController.createPost();
                });
          }),
        ],
      ),
    );
  }
}
