import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/screens/home/home.dart';
import 'package:multimeister/screens/profile_page.dart';
import 'package:multimeister/services/hive.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool showHome;
  const CustomAppBar({Key? key, this.showHome = true}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.Yellow,
      toolbarHeight: 50,
      leading: showHome
          ? IconButton(
              icon: const Icon(
                Icons.home,
                size: 24,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            )
          : Container(),
      actions: [
        ElevatedButton(
          onPressed: () {
            final hiveUser = HiveServices().getUserData();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        user: hiveUser!,
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
