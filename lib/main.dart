import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/screens/add_work_item_page.dart';
import 'package:multimeister/screens/home/home_wrapper.dart';
import 'package:multimeister/services/hive.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:multimeister/services/auth.dart';
import 'package:multimeister/ui_components/ui_specs.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await HiveServices().initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseUser?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          title: 'Multimeister',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.DarkGray, secondary: AppColors.Yellow),
          ),
          home: HomeWrapper(),
          //AddWorkItemPage(),
        ));
  }
}
