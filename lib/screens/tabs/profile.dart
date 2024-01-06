// profile.dart
import 'package:bitz/components/avatar_image.dart';
import 'package:bitz/components/button.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Container _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          // Profile image and name
          const Column(
            children: [
              AvatarImage(
                  size: 136, imageUrl: 'https://i.pravatar.cc/300?img=52'),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Account
          // Personalization
          // Logout
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: Button(
              text: 'Logout',
              color: MyColors.red,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
