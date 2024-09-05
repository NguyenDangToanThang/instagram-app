import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/registration_controller.dart';
import 'package:insta/app/screens/auth/widgets/button_auth.dart';
import 'package:insta/config/route/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: registrationController.formKeyRegistration,
                    child: Column(
                      children: [
                        Image.network(
                          "https://blog.ippon.fr/content/images/2023/09/RGFzaGF0YXJfRGV2ZWxvcGVyX092ZXJJdF9jb2xvcl9QR19zaGFkb3c-.png",
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: registrationController.fullnameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Tên người dùng',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy nhập tên người dùng";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: registrationController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy nhập email";
                            } else if (!GetUtils.isEmail(value)) {
                              return "Hãy nhập email hợp lệ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: registrationController.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy nhập mật khẩu";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Xác nhận mật khẩu',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy xác nhận mật khẩu";
                            }
                            if (value !=
                                registrationController
                                    .passwordController.text) {
                              return "Mật khẩu không khớp";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        Obx(() {
                          return ButtonAuth(
                              title: "Đăng ký",
                              loading: registrationController.loading.value,
                              onPress: () {
                                if (registrationController.formKeyRegistration.currentState!
                                    .validate()) {
                                  registrationController.register();
                                }
                              });
                        }),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: () {
                            Get.offNamed(Routes.loginScreen);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 10, 68, 214),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: Text(
                                "Đã có tài khoản? Đăng nhập",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Center(
                          child: Text(
                            "All Right Reserve",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
