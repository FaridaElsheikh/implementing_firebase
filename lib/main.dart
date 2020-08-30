import 'package:flutter/material.dart';
import 'package:implementing_firebase/models/user.dart';
import 'package:implementing_firebase/services/authService.dart';
import 'file:///D:/FlutterProjects/implementing_firebase/lib/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
