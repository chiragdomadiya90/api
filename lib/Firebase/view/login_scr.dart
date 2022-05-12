import 'package:api/Firebase/firebase_service/firebase_auth_service.dart';
import 'package:api/Firebase/view/home_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({Key? key}) : super(key: key);

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool visable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _email,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counter: const Offstage(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightBlueAccent, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightBlueAccent, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't be Empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: visable,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counter: const Offstage(),
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              visable = !visable;
                            });
                          },
                          icon: visable == false
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightBlueAccent, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightBlueAccent, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be Empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          SharedPreferences setData =
                              await SharedPreferences.getInstance();

                          bool status = await FirebaseAuthServices.logIn(
                              email: _email.text, password: _password.text);
                          if (status == true) {
                            setData.setString('Email', _email.text).then(
                                  (value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  ),
                                );

                            userCollection
                                .doc(kFirebaseAuth.currentUser!.uid)
                                .set({
                              "email": _email.text,
                              "password": _password.text,
                            });
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
