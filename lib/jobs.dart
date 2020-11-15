import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/add.dart';
import 'package:flutter_app/authentication.dart';
import 'package:flutter_app/groups.dart';
import 'package:flutter_app/homepage.dart';
import 'package:flutter_app/main.dart';


class Jobs extends StatelessWidget {

  final database = Firestore.instance;

  String docID;

  Map jobData = {};

  @override
  Widget build(BuildContext context) {

    jobData = ModalRoute.of(context).settings.arguments;
    print(jobData);
       return  Scaffold(
         backgroundColor: Colors.grey[200],
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
           centerTitle: true,
           title: Text(
             'Details',
             style: TextStyle(
               color: Colors.black,
             ),
           ),
           leading: GestureDetector(
             onTap: () {
               Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                     builder: (context) => HomePagee(),
                   ));
             },
             child: Icon(
               Icons.arrow_back_ios,
               size: 20,
               color: Colors.black,
             ),
           ),
         ),
         body: Container(
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(50),
                 topRight: Radius.circular(50),
               )
           ),
           child: Padding(
             padding: EdgeInsets.all(40),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Text(
                     jobData['Job'],
                     style: TextStyle(
                       fontSize: 32,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Center(
                   child: Text(
                     jobData['Address'],
                     style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                       color: Colors.grey,
                     ),
                   ),
                 ),

                 SizedBox(
                   height: 32,
                 ),

                 Text(
                   "Name",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Expanded(
                   child: Column(
                       children: [
                         Flexible(
                           child: Text(
                             jobData['Job'],
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                       ]
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Text(
                   "Contact Number",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Expanded(
                   child: Column(
                       children: [
                         Flexible(
                           child: Text(
                             jobData['Mobile'],
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                       ]
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Text(
                   "Job Description",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Expanded(
                     child: Column(
                       children: [
                         Flexible(
                           child: Text(
                             jobData['Job Description'],
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                        ]
                     ),
                     ),

                 SizedBox(
                   height: 16,
                 ),

                 Text(
                   "Contact Number",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Expanded(
                   child: Column(
                       children: [
                         Flexible(
                           child: Text(
                             jobData['Mobile'],
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                       ]
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Text(
                   "Requirements",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

                 Expanded(
                   child: Column(
                       children: [
                         Flexible(
                           child: Text(
                             jobData['Requirements'],
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                       ]
                   ),
                 ),

                 SizedBox(
                   height: 16,
                 ),

           Row(
             children: [

               Container(
                 height: 60,
                 width: 60,
                 child: Center(
                   child: Icon(
                     Icons.verified_user,
                     size: 28,
                   ),
                 ),
               ),

               SizedBox(
                 width: 16,
               ),
                     Expanded(
                       child: Container(
                         height: 60,
                         decoration: BoxDecoration(
                           color: Colors.red[500],
                           borderRadius: BorderRadius.all(
                             Radius.circular(10),
                           ),
                         ),
                         child: Center(
                           child: Text(
                             "Apply Now",
                             style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     ),

                   ],
                 ),
           ]),
           ),
         ));
  }
  }