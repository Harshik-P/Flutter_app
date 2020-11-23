import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {

  String doername;
  String givername;
  String jobname;
  String uid;

  FirebaseUser userData;


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
            children: [
                   Expanded(
                            child: StreamBuilder(
                                stream: getJobsSnapshots(context),
                                builder: (context, snapshot) {
                                  if(!snapshot.hasData) return const Text("Loading....");
                                  return new ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return JobCard(context, snapshot.data.documents[index]);
                                      });
                                }
                            ),
                          ),
                        ]
                  ));
  }


  Stream<QuerySnapshot> getJobsSnapshots(BuildContext context) async* {
    userData = await FirebaseAuth.instance.currentUser();
    uid = userData.uid;

    yield* Firestore.instance.collection('notifications').where("userID", isEqualTo: uid).orderBy("Datetym", descending: true).snapshots();
    print(uid);t
  }


  Widget JobCard(BuildContext context, DocumentSnapshot notification) {

    doername = notification['jobdoerName'];
    givername = notification['jobgivername'];
    jobname = notification['jobname'];
    Timestamp date = notification['Datetym'];
    DateTime showDate = date.toDate();
    showDate.toString();
    print(doername);

    return new Container(
      child:  Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Align(
                  child: new Text("$doername accepted your $jobname",style: TextStyle(fontSize: 23.0),),
                  alignment: Alignment(-0.8, 0),
                ),
                subtitle: Align(
                  child: new Text("$showDate" ,style: TextStyle(fontSize: 16.0),),
                  alignment: Alignment(-0.8, 0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                dense: true,
                onTap: () {
                },
              ),
              Divider(
                height: 10.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}