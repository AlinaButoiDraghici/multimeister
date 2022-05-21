import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/screens/onboarding/login_page.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BaseUser?>(context);

    if (user == null) {
      return LoginPage();
    }
    //TODO: change user provider implementation to storing user in hive/shared preferences##

    // find a way to change user provider value onPressed
    // if onboarding is not finished
    // else if ((user.firstName ?? '').isEmpty ||
    //     (user.lastName ?? '').isEmpty ||
    //     (user.phone ?? '').isEmpty ||
    //     (user.city ?? '').isEmpty) {
    //   return OnboardingFirstPage();
    // }
    else {
      return Home();
    }
  }
}
