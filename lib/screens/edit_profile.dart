import 'package:flutter/material.dart';
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
            CustomTextField(label: "Nume"),
            SizedBox(height: AppMargins.M),
            CustomTextField(label: "Prenume"),
            SizedBox(height: AppMargins.M),
            CustomTextField(
              label: "Telefon",
              icon: Icons.phone,
            ),
            SizedBox(height: AppMargins.M),
            CustomTextField(
              label: "Localitate",
              icon: Icons.location_city,
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
                  onPressed: () {},
                  text: "Editeaza",
                )
              ],
            ),
          ]),
        ))));
  }
}
