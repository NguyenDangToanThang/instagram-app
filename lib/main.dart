import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/bindings/home_binding.dart';
import 'package:insta/app/bindings/login_binding.dart';
import 'package:insta/app/bindings/registration_binding.dart';
import 'package:insta/app/screens/auth/login_screen.dart';
import 'package:insta/app/screens/auth/registration_screen.dart';
import 'package:insta/app/screens/pages/home_screen.dart';
import 'package:insta/config/route/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Insta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialRoute: Routes.loginScreen,
      getPages: getPages,
    );
  }
}

final getPages = [
  GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding()),
  GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding()),
  GetPage(
    name: Routes.registrationScreen,
    page: () => const RegistrationScreen(),
    binding: RegistrationBinding(),
  ),
];
