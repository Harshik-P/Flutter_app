import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/register.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Signup.dart';
import 'register.dart';
import 'homepage.dart';
import 'home_view.dart';
import 'add.dart';
import 'groups.dart';
import 'jobs.dart';
import 'profilepage.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        'landingpage' : (BuildContext context) => new MyApp(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/register': (BuildContext context) => new RegisterPage(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/homeview': (BuildContext context) => new HomeView(),
        '/add': (BuildContext context) => new AddPage(),
        '/profile': (BuildContext context) => new ProfilePage()
      },

      home: new MyHomePage(),
    );
  }
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("YOLO"),
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                    child : Center(
                        child:Image.asset('assets/signlogo.png',
                            height: 150,
                            width: 90
                        ),
                ),
                ),
              ],

            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo[800])
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  }
                ),
                SizedBox(height: 20.0,),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo[800])
                      )
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  }
                ),
                SizedBox(height: 5.0,),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text('Forgot Password',
                      style: TextStyle(
                          color: Colors.indigo[800],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0,),
                Container(
                  height: 40.0,
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.indigoAccent,
                      color: Colors.indigo[800],
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((user) {
                            Navigator.of(context).pushReplacementNamed('/homepage');
                          })
                          .catchError((e) {
                            print(e);
                          });
                        },
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: 23.0,),
                Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: InkWell(
                      onTap: () {
                        _signInWithGoogle();
                      },
                      child:

                      Center(
                        child: Text('Sign in with Google',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),


                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Yolo ?',
                      style: TextStyle(
                          fontFamily: 'Montserrat'
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text('Signup',
                        style: TextStyle(
                            color: Colors.indigo[800],
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
  }

}