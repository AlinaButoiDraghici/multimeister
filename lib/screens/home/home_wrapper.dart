import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/screens/onboarding/login_page.dart';
import 'package:multimeister/services/database.dart';
import 'package:provider/provider.dart';

import '../../services/hive.dart';
import '../onboarding/onboarding_first_page.dart';
import 'home.dart';

class HomeWrapper extends StatefulWidget {
  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BaseUser?>(context);
    final hiveUser = HiveServices().getUserData();
    final DatabaseService databaseService = DatabaseService();
    if (user == null) {
      return LoginPage();
    } else {
      return FutureBuilder(
        future: databaseService.getCurrentUser(user.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            BaseUser? firebaseUser = snapshot.data;
            if (firebaseUser != null) {
              HiveServices().addUserToBox(firebaseUser);
              return Home();
            } else {
              return OnboardingFirstPage();
            }
          } else if (snapshot.hasError) {
            return OnboardingFirstPage();
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      );
    }
  }
}
