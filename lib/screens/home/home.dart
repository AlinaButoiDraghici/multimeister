import 'package:flutter/material.dart';
import 'package:multimeister/services/auth.dart';

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
        child: Center(child: Text("Multimeister")),
      ),
    );
  }
}
