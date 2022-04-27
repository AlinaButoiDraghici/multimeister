import 'package:flutter/material.dart';
import 'package:multimeister/screens/home.dart';
import 'package:multimeister/screens/profile_page.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: AppColors.DarkGray, secondary: AppColors.Yellow),
      ),
      home: ProfilePage(isMeister: true),
    );
  }
}
