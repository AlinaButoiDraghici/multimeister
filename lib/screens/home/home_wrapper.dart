import 'package:flutter/material.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/screens/auth/authenticate.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<BaseUser?>(context);
    
    if (user == null){
      return Authenticate();
    }

    return Home();
  }
  
}