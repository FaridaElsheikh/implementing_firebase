import 'package:flutter/material.dart';
import 'package:implementing_firebase/screens/authenticate/register.dart';
import 'package:implementing_firebase/services/authService.dart';
import 'package:implementing_firebase/constants.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String _error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('SignUp'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: inputTextDecoration.copyWith(hintText: 'Email'),
                  validator: (value) =>
                      value.isEmpty ? "please provide an email" : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: inputTextDecoration.copyWith(hintText: 'Password'),
                  validator: (value) =>
                      value.isEmpty ? "please provide a password" : null,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Sign in '),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInEmailPassword(email, password);
                      if(result==null){
                        setState(() {
                          _error="Please make sure you have a valid account";
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(_error),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                      dynamic result = await _auth.signInWithGoogle();
                  },
                  child: Text('Sign in with Google '),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    dynamic result = await _auth.signInWithFacebook();
                  },
                  child: Text('Sign in with Facebook '),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
