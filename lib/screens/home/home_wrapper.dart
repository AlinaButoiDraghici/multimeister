import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/screens/onboarding/login_page.dart';
import 'package:provider/provider.dart';

import '../../services/hive.dart';
import '../onboarding/onboarding_first_page.dart';
import 'home.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BaseUser?>(context);
    final hiveUser = HiveServices().getUserData();

    if (user == null) {
      return LoginPage();
    }
    // ((user.firstName ?? '').isEmpty ||
    //     (user.lastName ?? '').isEmpty ||
    //     (user.phone ?? '').isEmpty ||
    //     (user.city ?? '').isEmpty)
    else if (hiveUser == null) {
      return OnboardingFirstPage();
    } else {
      return Home();
    }
  }
}
