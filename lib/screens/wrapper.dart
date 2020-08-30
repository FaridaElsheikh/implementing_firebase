
import 'package:flutter/material.dart';
import 'package:implementing_firebase/models/user.dart';
import 'package:implementing_firebase/screens/authenticate/authenticate.dart';
import 'package:implementing_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
