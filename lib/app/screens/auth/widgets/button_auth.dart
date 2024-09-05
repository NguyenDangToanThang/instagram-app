import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 10, 68, 214),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
