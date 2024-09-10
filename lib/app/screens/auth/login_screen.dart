import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/login_controller.dart';
import 'package:insta/app/screens/auth/widgets/button_auth.dart';
import 'package:insta/config/route/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  Image.network(
                    "https://blog.ippon.fr/content/images/2023/09/RGFzaGF0YXJfRGV2ZWxvcGVyX092ZXJJdF9jb2xvcl9QR19zaGFkb3c-.png",
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: loginController.formKeyLogin,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                          controller: loginController.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Hãy nhập mật khẩu";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          return ButtonAuth(
                            title: "Đăng nhập",
                            loading: loginController.loading.value,
                            onPress: () {
                              if (loginController.formKeyLogin.currentState!
                                  .validate()) {
                                loginController.login();
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "Bạn quên mật khẩu?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Get.offNamed(Routes.registrationScreen);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 10, 68, 214),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Tạo tài khoản mới",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Đã đăng ký bản quyền.",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
