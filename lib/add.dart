import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'services/crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();

}

class _AddPageState extends State<AddPage> {

  FirebaseUser User;
  String uid;
  Future<void> getCurrentUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      User = user;
      uid = user.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUid();
  }

  TextEditingController addController = TextEditingController();
  final database = Firestore.instance;

  String docid;
  String fname;
  String job;
  String job_desc;
  String addr;
  String mob;
  String req;

  crudMethods crudObj = new crudMethods();

  Map<String, String> jobData = Map();

  void addSearchkey(String jobname) {
    List<String> splitList = jobname.split(" ");
    List<String> indexList = [];

    for(int i = 0; i < splitList.length; i++) {
      for(int j = 1; j < splitList[i].length + 1; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }

     DocumentReference documentReference = database.collection('Jobs').document();
     documentReference.setData({'Full Name': this.fname, 'Job': this.job, 'Job Description': this.job_desc, 'Mobile': this.mob, 'Address': this.addr,
      'Requirements': this.req, 'searchIndex': indexList, 'uid': this.uid});

     print(documentReference.documentID);
     docid = documentReference.documentID;
  }

  String sendDocument() {
    return docid;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                        controller: addController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                            fname = value;
                          });
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      controller: addController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'JOB',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                            job = value;
                          });
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(50, 100))),
                          labelText: 'JOB DESCRIPTION',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                           job_desc  = value;
                          });
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(50, 100))),
                            labelText: 'Requirements',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                            req = value;
                          });
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'ADDRESS ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                            addr = value;
                          });
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          hintText: 'MOBILE NUMBER ',
                          hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent))),
                        onChanged: (value) {
                          setState(() {
                            mob = value;
                          });
                        }
                    ),
                    SizedBox(height: 30.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.indigoAccent,
                          color: Colors.indigo,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/homepage');
                              addSearchkey(addController.text);
                            },
                            child: Center(
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
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
                            Navigator.of(context).pop();
                          },
                          child:

                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),


                        ),
                      ),
                    ),
                  ],
                )),
          ]),
        ));
  }
}
