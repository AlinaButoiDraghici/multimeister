import 'package:flutter/material.dart';
import 'package:multimeister/constants/string_constants.dart';
import 'package:multimeister/screens/onboarding/register_page.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/custom_textfield.dart';

import '../../services/auth.dart';
import '../../ui_components/ui_specs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Image.asset(
              "assets/images/logo_title.png",
              width: 300,
            ),
          ),
          SizedBox(height: AppMargins.L),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _emailFormKey,
              child: CustomTextField(
                label: StringConstants.emailString,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return StringConstants.validEmailString;
                  }
                  // Check if the entered email has the right format
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                    return StringConstants.validEmailString;
                  }
                  // Return null if the entered email is valid
                  return null;
                },
                controller: _emailController,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _passwordFormKey,
              child: CustomTextField(
                label: StringConstants.passwordString,
                isPassword: true,
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return StringConstants.validPasswordString;
                  }
                  return null;
                },
                controller: _passwordController,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(AppMargins.M),
              child: CustomButton(
                  onPressed: () async {
                    if (_emailFormKey.currentState!.validate() &&
                        _passwordFormKey.currentState!.validate()) {
                      String result = await _auth.signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                      if (!result.contains("succes")) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      }
                    }
                  },
                  text: StringConstants.loginString)),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: InkWell(
              //navigate to register
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(StringConstants.noAccountString,
                  style: TextStyle(
                      fontSize: AppFontSizes.M, color: AppColors.Yellow)),
            ),
          ),
        ]),
      )),
    );
  }
}
