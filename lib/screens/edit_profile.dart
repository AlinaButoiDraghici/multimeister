import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/models/hive_user.dart';
import 'package:multimeister/screens/profile_page.dart';
import 'package:multimeister/services/database.dart';
import 'package:multimeister/services/hive.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/custom_textfield.dart';

import '../ui_components/custom_app_bar.dart';
import '../ui_components/ui_specs.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstNameFormKey = GlobalKey<FormState>();
  final _lastNameFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _cityFormKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  final HiveUser loggedUser = HiveServices().getUserData()!;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: loggedUser.firstName);
    _lastNameController = TextEditingController(text: loggedUser.lastName);
    _phoneController = TextEditingController(text: loggedUser.phone);
    _cityController = TextEditingController(text: loggedUser.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
            child: Container(
                child: Center(
          child: Column(children: [
            SizedBox(height: AppMargins.M),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.DarkGray,
                  foregroundColor: Colors.white,
                  radius: 50,
                  // icon or photo
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                Positioned(
                  left: 65,
                  top: 70,
                  child: InkWell(
                    //change photo
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: AppColors.Yellow,
                      foregroundColor: AppColors.DarkGray,
                      radius: 15,
                      // icon or photo
                      child: Icon(
                        Icons.add,
                        size: 25,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: AppMargins.L),
            Form(
              key: _firstNameFormKey,
              child: CustomTextField(
                label: "Prenume",
                controller: _firstNameController,
              ),
            ),
            SizedBox(height: AppMargins.M),
            Form(
              key: _lastNameFormKey,
              child: CustomTextField(
                label: "Nume",
                controller: _lastNameController,
              ),
            ),
            SizedBox(height: AppMargins.M),
            Form(
              key: _phoneFormKey,
              child: CustomTextField(
                label: "Telefon",
                icon: Icons.phone,
                controller: _phoneController,
              ),
            ),
            SizedBox(height: AppMargins.M),
            Form(
              key: _cityFormKey,
              child: CustomTextField(
                label: "Localitate",
                icon: Icons.location_city,
                controller: _cityController,
              ),
            ),
            SizedBox(height: AppMargins.M),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isPrimary: false,
                  text: "Anuleaza",
                ),
                CustomButton(
                  onPressed: () async {
                    if (_firstNameFormKey.currentState!.validate() &&
                        _lastNameFormKey.currentState!.validate() &&
                        _phoneFormKey.currentState!.validate() &&
                        _cityFormKey.currentState!.validate()) {
                      BaseUser user = BaseUser(
                          uid: loggedUser.uid,
                          email: loggedUser.email,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phone: _phoneController.text,
                          isMeister: loggedUser.isMeister,
                          city: _cityController.text);
                      DatabaseService databaseService = DatabaseService();
                      String resultUser = await databaseService.addUser(user);
                      if (resultUser.contains("success")) {
                        HiveServices().addUserToBox(user);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    user: HiveServices().getUserData()!,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(resultUser)));
                      }
                    }
                  },
                  text: "Editeaza",
                )
              ],
            ),
          ]),
        ))));
  }
}
