import 'package:flutter/material.dart';
import 'package:multimeister/constants/string_constants.dart';
import 'package:multimeister/ui_components/custom_floating_button.dart';
import '../../ui_components/custom_textfield.dart';
import '../../ui_components/ui_specs.dart';
import 'onboarding_second_page.dart';

class OnboardingFirstPage extends StatefulWidget {
  const OnboardingFirstPage({Key? key}) : super(key: key);

  @override
  State<OnboardingFirstPage> createState() => _OnboardingFirstPageState();
}

class _OnboardingFirstPageState extends State<OnboardingFirstPage> {
  final _firstNameFormKey = GlobalKey<FormState>();
  final _lastNameFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _cityFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          if (_firstNameFormKey.currentState!.validate() &&
              _lastNameFormKey.currentState!.validate() &&
              _phoneFormKey.currentState!.validate() &&
              _cityFormKey.currentState!.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OnboardingSecondPage(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phone: _phoneController.text,
                          city: _cityController.text,
                        )));
          }
        },
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.all(AppMargins.S),
              child: Text(
                StringConstants.onboardingInfoTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppFontSizes.XL),
              )),
          SizedBox(height: AppMargins.L),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _firstNameFormKey,
              child: CustomTextField(
                label: StringConstants.firstNameString,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return StringConstants.emptyFormString;
                  }
                  return null;
                },
                controller: _firstNameController,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _lastNameFormKey,
              child: CustomTextField(
                label: StringConstants.lastNameString,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return StringConstants.emptyFormString;
                  }
                  return null;
                },
                controller: _lastNameController,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _phoneFormKey,
              child: CustomTextField(
                label: StringConstants.phoneString,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return StringConstants.emptyFormString;
                  }
                  return null;
                },
                controller: _phoneController,
                icon: Icons.phone,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Form(
              key: _cityFormKey,
              child: CustomTextField(
                label: StringConstants.cityString,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return StringConstants.emptyFormString;
                  }
                  return null;
                },
                controller: _cityController,
                icon: Icons.location_city,
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
