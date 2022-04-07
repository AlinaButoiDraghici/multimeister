import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_button.dart';

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
      body: Container(
          color: Colors.white,
          child: Center(
            child: CustomButton(
              text: "Press me",
              onPressed: () {},
            ),
          )
          //Center(child: Text("Multimeister")),
          ),
    );
  }
}
