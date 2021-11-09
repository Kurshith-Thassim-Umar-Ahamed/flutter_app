// @dart=2.9

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/new_register.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'admin_page.dart';
import 'tech_page.dart';
import 'user_page.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  _MyApp createState()=>_MyApp();
}

class _MyApp extends State<MyApp>{

  final _formKey = GlobalKey<FormState>();
  String txtemail, txtpassword;

  final _email = TextEditingController();
  final _password = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("Users");

  void _signIn() async{
    try{
      final newUser = await _auth.signInWithEmailAndPassword(email: txtemail, password: txtpassword);

      if(newUser != null){
        final FirebaseUser user = await _auth.currentUser();
        final userID = user.uid;

        await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(userID)
        .once()
        .then((DataSnapshot snapshot){
          setState(() {
            if(snapshot.value['role']=='Admin'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPage()));
            }
            else if(snapshot.value['role']=='User'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPage()));
            }
            else if(snapshot.value['role']=='Tech'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TechPage()));
            }
          });
        });
      }else{
        print('Fail');
      }
    }catch(e){
      print(e);
    }
  }

  void _resetItem(){
    _email.clear();
    _password.clear();
  }

  Widget portrait(){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'User email',
                            ),
                            onSaved: (value){
                              txtemail=value;
                            },
                            validator: validateEmail,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                            ),
                            onSaved: (value){
                              txtpassword=value;
                            },
                            validator: validatePassword,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState.validate()){
                                    _formKey.currentState.save();
                                    _signIn();
                                  }
                                },
                                child: Text('Login'),
                              ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: ElevatedButton(
                                onPressed: (){
                                  _resetItem();
                                },
                                child: Text('Clear'),
                              ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewRegister()));
                            },
                            child: Text('Create a new account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget landscape(){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'User email',
                            ),
                            onSaved: (value){
                              txtemail=value;
                            },
                            validator: validateEmail,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                            ),
                            onSaved: (value){
                              txtpassword=value;
                            },
                            validator: validatePassword,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState.validate()){
                                    _formKey.currentState.save();
                                    _signIn();
                                  }
                                },
                                child: Text('Login'),
                              ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: ElevatedButton(
                                onPressed: (){
                                  _resetItem();
                                },
                                child: Text('Clear'),
                              ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewRegister()));
                            },
                            child: Text('Create a new account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
        builder: (context, orientation) {
      if(orientation == Orientation.portrait){
        return portrait();
      }else{
        return landscape();
      }
    },
        ),
    );
  }



  String validateEmail(String email) {
    if (email.isEmpty){
      return 'Enter email address';
    }
    else{
      return null;
    }
  }

  String validatePassword(String password) {
    if (password.isEmpty){
      return 'Enter password';
    }
    else{
      return null;
    }
  }

}




