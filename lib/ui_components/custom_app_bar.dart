import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/screens/profile_page.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool showSearch;
  const CustomAppBar({Key? key, this.showSearch = false}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.Yellow,
      toolbarHeight: 50,
      leading: showSearch
          ? IconButton(
              icon: const Icon(
                Icons.search,
                size: 24,
              ),
              onPressed: () {},
            )
          : Container(),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        //check isMeister based on user info
                        isMeister: true,
                      )),
            );
          },
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
