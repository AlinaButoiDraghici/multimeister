import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.Yellow,
      toolbarHeight: 50,
      leading: IconButton(
        icon: const Icon(
          Icons.search,
          size: 24,
        ),
        onPressed: () {},
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.person),
          style: ElevatedButton.styleFrom(
              primary: AppColors.DarkGray,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12)),
        )
      ],
    );
  }
}
