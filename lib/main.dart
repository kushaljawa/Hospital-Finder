import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'signup.dart';
import 'dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/signup': (context) => new SignupPage(),
        '/dashboard': (context) => new DashBoard()
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              resizeToAvoidBottomPadding: false,
              body: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Transform(
                        transform: Matrix4.translationValues(
                            animation.value * width, 0.0, 0.0),
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 35.0, 0.0, 0.0),
                                child: Text('Hello',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product')),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                                child: Text('There',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product')),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(235.0, 100.0, 0.0, 0.0),
                                child: Text('.',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontFamily: 'Product')),
                              )
                            ],
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            delayedAnimation.value * width, 0.0, 0.0),
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'Product',
                                      fontSize: 20.0),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontFamily: 'Product'),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                SizedBox(height: 20.0),
                                TextField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'Product',
                                      fontSize: 20.0),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontFamily: 'Product'),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  obscureText: true,
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  alignment: Alignment(1.0, 0.0),
                                  padding:
                                      EdgeInsets.only(top: 15.0, left: 20.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Product'),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40.0),
                                Container(
                                  height: 55.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Login Button clicked");
                                    },
                                    child: Material(
                                      borderRadius: BorderRadius.circular(27.0),
                                      shadowColor: Colors.greenAccent,
                                      color: Colors.green,
                                      elevation: 7.0,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Product'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius:
                                          BorderRadius.circular(27.0)),
                                  height: 55.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _signIn()
                                          .then((FirebaseUser user) =>
                                              print(user))
                                          .catchError((e) => print(e));
                                      print("Clicked");
                                    },
                                    child: Material(
                                      shadowColor: Colors.transparent,
                                      color: Colors.transparent,
                                      elevation: 7.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: ImageIcon(AssetImage(
                                                'assets/icons8-google-480.png')),
                                          ),
                                          SizedBox(width: 10.0),
                                          Center(
                                            child: Text('Log in with Google',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product')),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            )),
                      ),
                      SizedBox(height: 15.0),
                      Transform(
                        transform: Matrix4.translationValues(
                            muchDelayedAnimation.value * width, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'New to app ?',
                                  style: TextStyle(fontFamily: 'Product'),
                                ),
                                SizedBox(width: 5.0),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Product'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/dashboard');
                                  },
                                  child: Text('Login as Guest',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Product')),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ));
        });
  }
}
