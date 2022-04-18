import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/custom_floating_button.dart';
import 'package:multimeister/ui_components/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
      ),
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomButton(
                  text: "Press me",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  label: "Name",
                ),
              ],
            ),
          )
          //Center(child: Text("Multimeister")),
          ),
    );
  }
}
