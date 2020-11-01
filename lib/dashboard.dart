import 'package:fa_stepper/fa_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge1/loginUser.dart';

class DashBoardScreen extends StatefulWidget {
  final String email;
  dynamic user;

  DashBoardScreen({@required this.email});
  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  int _currentStep = 0;

  FAStepperType _stepperType = FAStepperType.vertical;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<FAStep> _stepper = [
    FAStep(
        title: Row(
          children: [
            Icon(
              Icons.house_sharp,
              color: Colors.teal,
              size: 24.00,
            ),
            Icon(
              Icons.card_membership,
              color: Colors.teal,
              size: 24.00,
            )
          ],
        ),
        isActive: true,
        subtitle: Text('BVN Verification'),
        content: Column(children: <Widget>[
          // Text(),
          TextField(
            decoration: InputDecoration(labelText: 'Please Enter your BVN'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
          )
        ])),
    FAStep(
        title: Row(
          children: [
            Icon(
              Icons.photo_album_outlined,
              color: Colors.teal,
              size: 24.00,
            )
          ],
        ),
        subtitle: Text('Passport Verification'),
        content: Column(children: <Widget>[
          Icon(
            Icons.picture_in_picture,
            size: 80.00,
          ),
          SizedBox(
            height: 20.00,
          ),
          Text('Click to Upload a passport'),
          SizedBox(
            height: 40.00,
          ),
          Icon(
            Icons.folder_open_outlined,
            size: 80.00,
          ),
          SizedBox(
            height: 20.00,
          ),
          Text('Click to Utility bill'),
          SizedBox(
            height: 40.00,
          ),
        ])),
    FAStep(
        title: Row(
          children: [
            Icon(
              Icons.link,
              color: Colors.teal,
              size: 24.00,
            )
          ],
        ),
        subtitle: Text('Link Bank Account'),
        content: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Account number'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Account Name'),
          ),
        ]))
  ];
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    isUserLoggedIn().then((value) {
      print('Email:${value}');
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Icon(
              Icons.subject,
              color: Colors.white,
              size: 30.0,
            )),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => {
                    _auth.signOut().then((value) =>
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false))
                  })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('${widget.email}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://himdeve.eu/wp-content/uploads/2019/04/himdeve_beach.jpg'),
                backgroundColor: Colors.orangeAccent,
              ),
            )
          ],
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'KYC',
              style: TextStyle(fontSize: 40.00),
            ),
            FAStepper(
              physics: ClampingScrollPhysics(),
              steps: _stepper,
              type: _stepperType,
              currentStep: this._currentStep,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper.length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    _currentStep = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
          ],
        ),
      )),
    );
  }

  openDrawer(String user) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    return user;
  }

  isUserLoggedIn() async {
    // creating a firbase instance
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser().then((user) => user.email);
  }
}
