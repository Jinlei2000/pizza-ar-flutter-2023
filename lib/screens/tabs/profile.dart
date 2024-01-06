// profile.dart
import 'package:bitz/components/avatar_image.dart';
import 'package:bitz/components/button.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _body()),
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
          const SizedBox(
            width: double.infinity,
            child: Column(
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
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: accountItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index == accountItems.length - 1
                              ? BorderSide.none
                              : const BorderSide(
                                  color: MyColors.borderColor,
                                  width: 1,
                                ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            accountItems[index]['icon'],
                            size: 24,
                            color: MyColors.textPrimary,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            accountItems[index]['title'],
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
                  },
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
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: personalizationItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index == personalizationItems.length - 1
                              ? BorderSide.none
                              : const BorderSide(
                                  color: MyColors.borderColor,
                                  width: 1,
                                ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            personalizationItems[index]['icon'],
                            size: 24,
                            color: MyColors.textPrimary,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            personalizationItems[index]['title'],
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
                  },
                ),
              ),
            ],
          ),
          // Logout
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
}
