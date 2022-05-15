import 'package:flutter/material.dart';
import 'package:multimeister/services/auth.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/custom_floating_button.dart';
import 'package:multimeister/ui_components/custom_textfield.dart';
import 'package:multimeister/ui_components/review_tile.dart';
import 'package:multimeister/ui_components/work_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut(); 
            },
            label: Text("Sign-Out"),
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: [
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
          SizedBox(
            height: 100,
          ),
          ReviewTile(
            name: "Gigel Ion",
            area: "Timisoara",
            phone: "+40",
            rating: 3,
          ),
          SizedBox(
            height: 100,
          ),
          WorkCard(
            name: "Gigel Ion",
            area: "Timisoara",
            phone: "+40",
            title: "Mese lucrate manual",
            label: "Tamplarie",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          ),
        ]),
      ),
    );
  }
}
