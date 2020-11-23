import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'profilepage.dart';
import 'profilepage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  File _image;
  bool uploading = false;
  File file;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  String uid;

  Future<void> getCurrentUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }


  @override
  void initState() {
    super.initState();
    getCurrentUid();
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    saveItemInfo(String downloadUrl)
    {
      final itemsRef = Firestore.instance.collection("Images");
      itemsRef.document(uid).setData({
        "thumbnailUrl" : downloadUrl,
      });
    }

    Future uploadPic() async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot takeSnapshot=await uploadTask.onComplete;
      String downloadUrl = await takeSnapshot.ref.getDownloadURL();
      saveItemInfo(downloadUrl);
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 25,
                        right: 90,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                              icon: Icon(Icons.edit,color: Colors.white,),
                              onPressed: () {
                                //pickPhotoFromGallery();
                                getImage();
                              }
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Full Name"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                    prefixText: 'FULL NAME',
                    prefixStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    hintText: 'FULL NAME',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Email"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    prefixText: 'E-MAIL ',
                    prefixStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    hintText: 'E-MAIL ',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("New Password"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    prefixText: 'NEW PASSWORD ',
                    prefixStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    hintText: 'NEW PASSWORD ',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Address"),
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    prefixText: 'LOCATION ',
                    prefixStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    hintText: 'LOCATION ',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // ignore: unnecessary_statements
                      //uploading ? null : () => uploadImageAndSaveItemInfo();
                      uploadPic();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}