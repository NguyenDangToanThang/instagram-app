import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/screens/pages/page/home_view.dart';
import 'package:insta/app/screens/pages/page/inbox_view.dart';
import 'package:insta/app/screens/pages/page/search_view.dart';
import 'package:insta/app/screens/pages/page/setting_view.dart';
import 'package:insta/app/screens/pages/page/up_post_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pageList = [
    const HomeView(),
    const SearchView(),
    const UpPostView(),
    const InboxView(),
    const SettingView(),
  ];
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            index: homeController.index.value,
            onTap: (index) {
              homeController.changeIndex(index);
            },
            items: const [
              Icon(
                Icons.home,
                color: Colors.blue,
              ),
              Icon(
                Icons.search,
                color: Colors.blue,
              ),
              Icon(
                Icons.upload,
                color: Colors.blue,
              ),
              Icon(
                Icons.message,
                color: Colors.blue,
              ),
              Icon(Icons.settings, color: Colors.blue),
            ]),
        body: SafeArea(
          child: Obx(() => pageList[homeController.index.value]),
        ));
  }
}
