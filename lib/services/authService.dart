import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:implementing_firebase/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn=GoogleSignIn();

  //create use object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with email and password\
  Future signInEmailPassword(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

//sign in with google
  Future signInWithGoogle() async{
    try{
      final GoogleSignInAccount googleAccount=await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth=await googleAccount.authentication;
      final AuthCredential credential=GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      AuthResult result=await _auth.signInWithCredential(credential);
      return _userFromFirebaseUser(result.user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signInWithFacebook() async{
    try{
      final LoginResult facebookAuth=await FacebookAuth.instance.login();
      final AuthCredential credential=FacebookAuthProvider.getCredential(accessToken: facebookAuth.accessToken.token);
      AuthResult result=await _auth.signInWithCredential(credential);
      return _userFromFirebaseUser(result.user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

// register
  Future signUpEmailPassword(String email,String password) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
//signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
