import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'model/api_header.dart';

class Create_User extends StatefulWidget {
  const Create_User({Key? key}) : super(key: key);

  @override
  State<Create_User> createState() => _Create_UserState();
}

class _Create_UserState extends State<Create_User> {
  Future User(Map<String, dynamic> reqBody) async {
    Map<String, String> headers = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    http.Response response = await http.post(
        Uri.parse(
            'http://scprojects.in.net/projects/skoolmonk/api_/user/create'),
        body: reqBody,
        headers: headers);
    var results = jsonDecode(response.body);
    print('response ==>$results');
    if (response.statusCode == 200) {
      return results;
    } else {
      return null;
    }
  } //// aa future thi ahiya sudhi nu alag file ma banaviye to pan chale

  final _formkey = GlobalKey<FormState>();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _mob = TextEditingController();
  final _dob = TextEditingController();
  final _pass = TextEditingController();
  final _conpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _fname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First Name can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "FirstName"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _lname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last Name can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "LastName"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email can\'t be Empty';
                    }
                  },
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _dob,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Date of Birth can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "Date Of Birth"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _mob,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mobile number can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "Mobile Number"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _pass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  controller: _conpass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm Password can't be Empty";
                    }
                  },
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        UserModel _model = UserModel();
                        _model.fname = _fname.text;
                        _model.lname = _lname.text;
                        _model.email = _email.text;
                        _model.dob = _dob.text;
                        _model.mobile = _mob.text;
                        _model.password = _pass.text;
                        _model.confirmPassword = _conpass.text;
                        _model.clientKey = "1595922666X5f1fd8bb5f662";
                        _model.deviceType = 'MOB';

                        User(_model.toJson()).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('SuccessFull'),
                            ),
                          ),
                        );
                      }
                      ;
                    },
                    child: Text(
                      'SignIn',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
