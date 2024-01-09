// profile.dart
import 'package:bitz/components/avatar_image.dart';
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/my_custom_scroll_bar.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: MyCustomScrollBar(
          child: _body(),
        ),
      ),
    );
  }

  Container _body() {
    List<Map<String, dynamic>> accountItems = [
      {'title': 'Personalization', 'icon': LucideIcons.user2},
      {'title': 'Privacy & Security', 'icon': LucideIcons.lock},
      {'title': 'Billing', 'icon': LucideIcons.creditCard},
    ];

    List<Map<String, dynamic>> personalizationItems = [
      {'title': 'Theme', 'icon': LucideIcons.palette},
      {'title': 'Language', 'icon': LucideIcons.languages},
    ];

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile image and name
          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: const Column(
              children: [
                AvatarImage(
                    size: 136, imageUrl: 'https://i.pravatar.cc/300?img=52'),
                SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: MyColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Account
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MyColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              // Account items
              Container(
                decoration: BoxDecoration(
                  color: MyColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyColors.borderColor,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    _profileItem(0, accountItems),
                    _profileItem(1, accountItems),
                    _profileItem(2, accountItems),
                  ],
                ),
              ),
            ],
          ),
          // Personalization
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personalization',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MyColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              // Personalization items
              Container(
                decoration: BoxDecoration(
                  color: MyColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyColors.borderColor,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    _profileItem(0, personalizationItems),
                    _profileItem(1, personalizationItems),
                  ],
                ),
              ),
            ],
          ),
          // // Logout
          const SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
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

  Widget _profileItem(int index, List<Map<String, dynamic>> items) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: index == items.length - 1
              ? BorderSide.none
              : const BorderSide(
                  color: MyColors.borderColor,
                  width: 0.5,
                ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            items[index]['icon'],
            size: 24,
            color: MyColors.textPrimary,
          ),
          const SizedBox(width: 16),
          Text(
            items[index]['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: MyColors.textPrimary,
            ),
          ),
          const Spacer(),
          const Icon(
            LucideIcons.chevronRight,
            color: MyColors.textSecondary,
            size: 24,
          ),
        ],
      ),
    );
  }
}
