import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/follow_controller.dart';
import 'package:insta/app/models/follow.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final followController = Get.put(FollowController());
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: followController.searchEdittingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: const Icon(Icons.search),
                      label: const Text("Nhập tên người bạn muốn tìm")),
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (followController.followers.isEmpty) {
                  return const Center(child: Text("Bạn chưa theo dõi ai"));
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: followController.followers.length,
                        itemBuilder: (context, index) {
                          final Follow follow =
                              followController.followers[index];
                          return ListTile(
                              title: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                follow.email,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  "Đang theo dõi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                              subtitle: Text(
                                follow.fullname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: follow.avatar == ""
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/avatar.jpg"))
                                  : CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(follow.avatar)));
                        }),
                  );
                }
              })
            ],
          ),
        ));
  }
}
