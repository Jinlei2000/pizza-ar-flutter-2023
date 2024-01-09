import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparent;
  final Function()? onDeleteTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.transparent = false,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: SafeArea(
        top: true,
        child: Container(
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
                style: TextStyle(
                  color: transparent ? Colors.white : MyColors.textPrimary,
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
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required Function() onTap}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: transparent ? MyColors.blur : MyColors.appBarBackButton,
        border: Border.all(
          color: MyColors.borderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: transparent ? Colors.white : MyColors.gray950,
          size: 24,
        ),
      ),
    );
  }
}
