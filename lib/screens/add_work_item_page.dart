import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/custom_carousel_slider.dart';

import '../constants/string_constants.dart';
import '../ui_components/custom_floating_button.dart';
import '../ui_components/custom_textfield.dart';
import '../ui_components/ui_specs.dart';

class AddWorkItemPage extends StatefulWidget {
  const AddWorkItemPage({Key? key}) : super(key: key);

  @override
  State<AddWorkItemPage> createState() => _AddWorkItemPageState();
}

class _AddWorkItemPageState extends State<AddWorkItemPage> {
  final _workTypeFormKey = GlobalKey<FormState>();
  final _workTitleFormKey = GlobalKey<FormState>();
  final _priceFormKey = GlobalKey<FormState>();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _workTitleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
        icon: Icons.check,
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            SizedBox(height: AppMargins.L),
            Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: Text(
                  StringConstants.addWorkItemString,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: AppFontSizes.XL),
                )),
            SizedBox(height: AppMargins.L),
            Padding(
              padding: EdgeInsets.all(AppMargins.S),
              child: Form(
                key: _workTypeFormKey,
                child: CustomTextField(
                  label: StringConstants.workTypeString,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return StringConstants.emptyFormString;
                    }
                    return null;
                  },
                  controller: _workTypeController,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppMargins.S),
              child: Form(
                key: _workTitleFormKey,
                child: CustomTextField(
                  label: StringConstants.workTitleString,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return StringConstants.emptyFormString;
                    }
                    return null;
                  },
                  controller: _workTitleController,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppMargins.S),
              child: Form(
                key: _priceFormKey,
                child: CustomTextField(
                  label: StringConstants.priceString,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return StringConstants.emptyFormString;
                    }
                    return null;
                  },
                  controller: _priceController,
                  icon: Icons.euro,
                ),
              ),
            ),
            SizedBox(height: AppMargins.S),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: CustomFloatingButton(
                  icon: Icons.add_a_photo,
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: CustomCarouselSlider(),
            ),
            SizedBox(height: AppMargins.M),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: Text(
                  StringConstants.addAnotherWorkItemString,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.L,
                      color: AppColors.Yellow),
                ),
              ),
            ),
          ]))),
    );
  }
}
