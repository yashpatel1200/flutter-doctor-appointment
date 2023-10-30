// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class AddUserPage extends StatelessWidget {
//   AddUserPage({super.key});

//   var formKey = GlobalKey<FormState>();
//   var nameController = TextEditingController();
//   var salaryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Form(
//         child: Column(children: [
//           TextFormField(
//             decoration: InputDecoration(hintText: 'Enter Name'),
//             validator: ((value) {
//               if(value!=null && value.isEmpty){
//                 return "Enter Valid Name";
//               }
//             }),
//             controller: nameController,
//           ),
//           TextFormField(
//             decoration: InputDecoration(hintText: 'Enter salary'),
//             validator: ((value) {
//               if(value!=null && value.isEmpty){
//                 return "Enter Valid Salary";
//               }
//             }),
//             controller: salaryController,
//           ),
//           TextButton(onPressed: () {
//             if(formKey.currentState!.validate()){
//               insertUser();
//             }
//           }, child: Text('Submit'))
//         ]),
//       ),
//     ));
//   }

//   Future<void> insertUser() async {
//     Map map = {};
//     map['name'] = nameController.text;
//     map['salary'] = salaryController.text;

//     var res = await http.post(Uri.parse('https://630ee9663792563418834e75.mockapi.io/empoyee'),body: map);
//     print(res.body);
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../const.dart';
class Student extends StatefulWidget {
  @override
  State<Student> createState() => _StudentState();

  dynamic? map;
  Student(this.map);

  GlobalKey<FormState> formkey = GlobalKey();
  var Firstname = new TextEditingController();
  var Lastname = new TextEditingController();
  var Mobilenumber = new TextEditingController();
  var Email = new TextEditingController();

}

class _StudentState extends State<Student> {
  @override
  void initState(){
    widget.Firstname.text = widget.map==null?'':widget.map['Firstname'];
    widget.Lastname.text = widget.map==null?'':widget.map['Lastname'];
    widget.Mobilenumber.text = widget.map==null?'':widget.map['Mobilenumber'];
    widget.Email.text = widget.map==null?'':widget.map['Email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Appointment'),
        backgroundColor: purple,
      ),
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: widget.Firstname,
              decoration: InputDecoration(
                hintText: "Enter First Name",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Last Name",
              ),
              controller: widget.Lastname,
            ),
          ),
          Container(
            child: TextFormField(
              controller: widget.Mobilenumber,
              decoration: InputDecoration(
                hintText: "Enter Mobile Number",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: widget.Email,
              decoration: InputDecoration(
                hintText: "Enter Email",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(widget.map==null){
                  await addEmployee().then((value) => (value) {

                  });
                }
                else{
                  await editEmployee().then((value) => (value) {
                    setState(() {

                    });
                  });
                }

                Navigator.of(context).pop(true);

              }, child: Text("Submit",style: TextStyle(fontSize: 24),),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addEmployee() async{
    var map ={};
    map['Firstname']=widget.Firstname.text;
    map['Lastname']=widget.Lastname.text;
    map['Mobilenumber']=widget.Mobilenumber.text;
    map['Email']=widget.Email.text;
    var response1 = http.post(Uri.parse("https://63f5d3c659c944921f6741f9.mockapi.io/Student",),body: map);
  }

  Future<void> editEmployee() async{
    var map ={};
    map['Firstname']=widget.Firstname.text;
    map['Lastname']=widget.Lastname.text;
    map['Mobilenumber']=widget.Mobilenumber.text;
    map['Email']=widget.Email.text;
    var response1 = http.put(Uri.parse("https://63f5d3c659c944921f6741f9.mockapi.io/Student/"+widget.map['id'].toString(),),body: json.encode(map),headers: {"Content-Type": "application/json"},);
  }
}