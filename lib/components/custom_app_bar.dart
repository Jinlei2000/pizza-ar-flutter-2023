import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onDeleteTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Back button
            _buildIconButton(
              icon: LucideIcons.arrowLeft,
              onTap: () => {
                // Go back to the previous screen
                Navigator.pop(context),
              },
            ),

            // Title
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: MyColors.gray950,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),

            // Delete button
            const Spacer(),
            if (onDeleteTap != null)
              _buildIconButton(
                icon: LucideIcons.trash2,
                onTap: onDeleteTap!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required Function() onTap}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: MyColors.appBarBackButton,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: MyColors.borderColor,
          width: 0.5,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: MyColors.gray950,
          size: 24,
        ),
      ),
    );
  }
}
