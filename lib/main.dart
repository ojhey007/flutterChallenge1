import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge1/dashboard.dart';
import 'package:flutter_challenge1/loginUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "Raleway",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // check if user is logged or not
    isUserLoggedIn().then((value) {
      if (value == true) {
        print("Already Logged in");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoardScreen(
                      email: '',
                    )),
            (route) => false);
      } else {
        print("Not Logged in");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
    return Scaffold(
      body: Card(
        child: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
          ),
        ),
      ),
    );
  }

  isUserLoggedIn() async {
    // creating a firbase instance
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth
        .currentUser()
        .then((user) => user != null ? true : false)
        .catchError((onError) => false);
  }
}
