import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

  final Function toggleView;

  Register({ required this.toggleView });
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Create Account'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.lock, color: Colors.white),
            label: Text('Sign-In', style: TextStyle(color: Colors.white),),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(label: Text("E-mail")),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Check if the entered email has the right format
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                    return 'Please enter a valid email address';
                  }
                  // Return null if the entered email is valid
                  return null;
                },
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(label: Text("Password")),
                obscureText: true,
                validator: (val) { 
                  int length = val!.length;
                  if (val.trim().isEmpty) {
                    return 'Please enter a password address';
                  }
                  if (length < 6) {
                    return 'Enter a password 6+ chars long';
                  }

                  return null;
                },
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  bool? formState = _formKey.currentState?.validate();
                  if(formState == true){
                    BaseUser? result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => error = 'Please supply a valid email' );
                    }
                  }
                }
              ),
              const SizedBox(height: 12.0),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),)
            ],
          ),
        ),
      ),
    );
  }
}