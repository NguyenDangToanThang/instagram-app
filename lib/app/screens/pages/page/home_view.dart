import 'package:flutter/material.dart';
import 'package:insta/app/screens/pages/widgets/post_view_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: PostViewList(),
          ),
        ],
      ),
    );
  }
}
