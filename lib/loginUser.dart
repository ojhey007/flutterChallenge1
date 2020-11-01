import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_challenge1/dashboard.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "HACATHON",
      logo: 'assets/images/logo.png',
      theme: LoginTheme(
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
        ),
        textFieldStyle: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
      ),
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () async {
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => DashBoardScreen()));
        FirebaseAuth _auth = FirebaseAuth.instance;
        await _auth.currentUser().then((user) {
          if (user != null) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => DashBoardScreen(email: '${user.email}')));
          } else {
            Fluttertoast.showToast(msg: "User not found, please signup");
          }
        });
      },
      onRecoverPassword: _recoveryPassword,
    );
  }

  Future<String> _loginUser(LoginData loginData) {
    _handleSignIn(loginData.name.trim(), loginData.password)
        .then((user) => Fluttertoast.showToast(
            msg: 'Welcome: ${user.email}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16))
        .catchError((err) => Fluttertoast.showToast(
            msg: '${err}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16));
  }

  Future<FirebaseUser> _handleSignIn(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser _user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }

  Future<String> _signUpUser(LoginData loginData) {
    _handleSignUp(loginData.name.trim(), loginData.password)
        .then((user) => Fluttertoast.showToast(
            msg: 'Welcome: ${user.email}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16))
        .catchError((err) => Fluttertoast.showToast(
            msg: '${err}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16));
  }

  Future<FirebaseUser> _handleSignUp(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser _user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }

  Future<String> _recoveryPassword(String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email).catchError((err) =>
        Fluttertoast.showToast(
            msg: '${err}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16));
  }

  Future<FirebaseUser> _ifLoginError() async {
    // Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => LoginScreen()));
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //     (route) => false);
  }
}
