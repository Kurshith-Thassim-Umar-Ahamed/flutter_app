import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mad_assignment/main.dart';


class NewRegister extends StatefulWidget{
  _NewRegister createState()=>_NewRegister();
}

class _NewRegister extends State<NewRegister>{

  //real time database
  final databaseReference = FirebaseDatabase.instance.reference().child("Users");
  /*final DatabaseReference  databaseReference = FirebaseDatabase.instance.reference().child("Users");*/

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String txtname, txtemail, txtpassword, txtrole='';

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _resetItem(){
    _name.clear();
    _email.clear();
    _password.clear();
  }

  void _saveItem() async {
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(email: txtemail, password: txtpassword);
      if (newUser != null){
        final FirebaseUser user = await _auth.currentUser();
        final userID =user.uid;

        _addUsers(userID);
      }
    }catch(e){
      print(e);
    }
  }

  //real time database
  void _addUsers(String userID){
    databaseReference.child(userID).set({
      'name':txtname,
      'role':txtrole,
      'email':txtemail,
      'userID':userID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create A New Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Name',
                  ),
                  onSaved: (value){
                    txtname=value!;
                  },
                  validator: validateName,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Email ID',
                  ),
                  onSaved: (value){
                    txtemail=value!;
                  },
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Password',
                  ),
                  onSaved: (value){
                    txtpassword=value!;
                  },
                  validator: validatePassword,
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField(decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelText: 'Role',
                ),
                  value: txtrole.isNotEmpty ? txtrole : null,
                  items: <String>['User', 'Tech', 'Admin']
                      .map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      txtrole = value.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      onPressed: (){
                        _resetItem();
                      },
                      child: Text('Reset'),
                    ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          _saveItem();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Alert!!"),
                              content: new Text("You are successfully registered!"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                                  },
                                ),
                              ],
                            );
                            },
                          );
                        }
                      },
                      child: Text('Register'),
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  String? validateName(String? name) {
    if (name!.isEmpty){
      return 'Enter your name';
    }
    else{
      return null;
    }
  }

  String? validateEmail(String? email) {
    if (email!.isEmpty){
      return 'Enter your email';
    }
    else{
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty){
      return 'Enter password';
    }
    else{
      return null;
    }
  }
}