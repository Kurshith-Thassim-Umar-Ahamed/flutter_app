import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/screen/task.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final databaseReference = FirebaseDatabase.instance.reference().child("Tasks");

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  late String txtauthname, txtdescription, txtdate, txtemail, txttechemail;

  final _authname = TextEditingController();
  final _email = TextEditingController();
  final _description = TextEditingController();
  final dateController = TextEditingController();
  final _techemail = TextEditingController();

  void _resetItem(){
    _authname.clear();
    _email.clear();
    _description.clear();
    dateController.clear();
    _techemail.clear();
  }

  void _saveTask() async {
    try{
        final FirebaseUser user = await _auth.currentUser();
        final userID =user.uid;
        _addTask(userID);

    }catch(e){
      print(e);
    }
  }

  //real time database
  void _addTask(String userID){
    databaseReference.push().set({
      'userID':userID,
      'email':txtemail,
      'authname':txtauthname,
      'description':txtdescription,
      'finalDate':txtdate,
      'techEmail':txttechemail
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add a Task'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _authname,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Author Name',
                  ),
                  onSaved: (value){
                    txtauthname=value!;
                  },
                  validator: validateAuthorName,
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
                  controller: _description,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Description',
                  ),
                  onSaved: (value){
                    txtdescription=value!;
                  },
                  validator: validateDescription,
                ),
                SizedBox(
                  height: 10.0,
                ),
                //tech email
                TextFormField(
                  controller: _techemail,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Tech Email ID',
                  ),
                  onSaved: (value){
                    txttechemail=value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Date before to respond',
                      hintText: 'Pick your Date'
                  ),
                  onTap: ()async{
                    var date =  await showDatePicker(
                        context: context,
                        initialDate:DateTime.now(),
                        firstDate:DateTime(1900),
                        lastDate: DateTime(2100));
                    dateController.text = date.toString().substring(0,10);
                  },
                  onSaved: (value){
                    txtdate=value!;
                  },
                  validator: validateDate,
                ),
                SizedBox(
                  height: 10.0,
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
                          _saveTask();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Alert!!"),
                                content: new Text("Task has been added successfully"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      _resetItem();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Add Task'),
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

  String? validateAuthorName(String? name) {
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

  String? validateDescription(String? description) {
    if (description!.isEmpty){
      return 'Enter task description';
    }
    else{
      return null;
    }
  }

  String? validateDate(String? date) {
    if (date!.isEmpty){
      return 'Select deadline';
    }
    else{
      return null;
    }
  }
}
