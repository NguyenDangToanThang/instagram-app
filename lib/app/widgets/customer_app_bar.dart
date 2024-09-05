import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insta/config/spacing.dart';

class CustomerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomerAppBar({
    super.key, 
    this.showBackButton = false, 
    this.showCartButton = true, 
    this.showDeleteButton = false, 
    this.onDelete, 
    required this.title });

  final bool showBackButton;
  final bool showCartButton;
  final bool showDeleteButton;
  final Function? onDelete;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleSpacing: screenPadding,
      centerTitle: false,
      scrolledUnderElevation: 0,
      leading: showBackButton ? Padding(
        padding: const EdgeInsets.fromLTRB(smSpacing, 0, 0, 0), 
        child: InkWell(
          onTap: () => Get.back(),
          child: SvgPicture.asset('assets/images/...'),
        ),
      ) : null,
      leadingWidth: 36,
      actions: [
        showCartButton ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, mdSpacing, 0),
          child: InkWell(
            onTap: () => Get.toNamed('/cart'),
            child: SvgPicture.asset('assets/images/...'),
          ),
        ) : const Text(''),
        showDeleteButton ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, mdSpacing, 0),
          child: InkWell(
            onTap: () => onDelete!,
            child: SvgPicture.asset('assets/images/...'),
          ),
        ) : const Text('')
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
