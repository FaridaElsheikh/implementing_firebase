import 'package:flutter/material.dart';
import 'package:implementing_firebase/constants.dart';
import 'package:implementing_firebase/services/authService.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('SignIn'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: inputTextDecoration.copyWith(hintText: 'Email'),
                validator: (value)=> value.isEmpty? 'Enter an email':null ,
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
                validator: (value)=> value.length<6? 'Password has to be more than 6 letters':null ,
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
                child: Text('Sign up '),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic user=await _auth.signUpEmailPassword(email, password);
                    if(user==null){
                      setState(() {
                        return error='please supply a valid email and password';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12,),
              Text(error,style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}
