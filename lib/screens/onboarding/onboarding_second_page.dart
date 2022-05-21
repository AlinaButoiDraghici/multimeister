import 'package:flutter/material.dart';
import 'package:multimeister/services/database.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
import '../../models/base_user.dart';
import '../../services/hive.dart';
import '../../ui_components/custom_floating_button.dart';
import '../../ui_components/ui_specs.dart';
import '../home/home.dart';

class OnboardingSecondPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String city;
  const OnboardingSecondPage(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.city})
      : super(key: key);

  @override
  State<OnboardingSecondPage> createState() => _OnboardingSecondPageState();
}

class _OnboardingSecondPageState extends State<OnboardingSecondPage> {
  bool? _isMeister;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: _isMeister != null,
        child: CustomFloatingButton(
          onPressed: () async {
            // add user model and save user in provider
            // navigate to add work item
            final userFromAuth = Provider.of<BaseUser?>(context, listen: false);
            if (userFromAuth != null) {
              BaseUser user = BaseUser(
                  uid: userFromAuth.uid,
                  email: userFromAuth.email,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  phone: widget.phone,
                  isMeister: _isMeister,
                  city: widget.city);
              DatabaseService databaseService = DatabaseService();
              String result = await databaseService.addUser(user);
              if (result.contains("success")) {
                HiveServices().addUserToBox(user);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } else {
                if (!result.contains("succes")) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                }
              }
            }
          },
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: Text(
                  StringConstants.onboardingInfoTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: AppFontSizes.XL),
                )),
            SizedBox(height: AppMargins.M),
            Padding(
              padding: EdgeInsets.all(AppMargins.S),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isMeister = true;
                          });
                        },
                        child: Image.asset(
                          "assets/images/bear_helmet.png",
                          width: 110,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppMargins.S),
                        child: Text(StringConstants.meisterString,
                            style: TextStyle(fontSize: AppFontSizes.M)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isMeister = false;
                          });
                        },
                        child: Image.asset(
                          "assets/images/bear.png",
                          width: 110,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppMargins.S),
                        child: Text(StringConstants.clientString,
                            style: TextStyle(fontSize: AppFontSizes.M)),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]))),
    );
    //},
    //);
  }
}
