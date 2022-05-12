import 'dart:io';
import 'dart:math';

import 'package:api/Firebase/firebase_service/firebase_auth_service.dart';
import 'package:api/Firebase/firebase_service/google_auth_service.dart';
import 'package:api/Firebase/view/login_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'google.dart';
import 'home_scr.dart';
import 'mob_number.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool visable = true;

  /// Gallery photo select

  File? _image;
  final picker = ImagePicker();
  Future pickedImage() async {
    final imagePicked = await picker.getImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
      });
    }
  }

  /// Upload File

  Future<String?> uploadFile({File? file, String? filename}) async {
    print("File Path ==> $file");
    try {
      var response = await storage.ref('filename ==>$filename').putFile(file!);

      return response.storage.ref('filename ==>$filename').getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  /// firebase ma userdata add karavva
  Future addUser() async {
    String? imageUrl = await uploadFile(
        filename:
            "${Random().nextInt(1000)}${kFirebaseAuth.currentUser!.email}",
        file: _image);

    userCollection.doc(kFirebaseAuth.currentUser!.uid).set({
      'user_name': _username.text,
      'email': _email.text,
      'password': _password.text,
      'image': imageUrl,
    }).catchError((e) {
      print("Error ==>$e");
    });
  }

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
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pickedImage();
                        });
                      },
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.black26, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        child: _image == null
                            ? const Icon(Icons.person)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _username,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counter: const Offstage(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'UserName',
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
                        return "User Name can't be Empty";
                      }
                    },
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle().whenComplete(
                            () => Get.to(
                              Google(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('assets/photo/google.png'),
                              scale: 1,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            EnterMobile(),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('assets/photo/ph.png'),
                              scale: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          SharedPreferences email =
                              await SharedPreferences.getInstance();

                          bool? status = await FirebaseAuthServices.signUp(
                              email: _email.text, password: _password.text);
                          if (status == true) {
                            email.setString("email", _email.text);
                            await addUser().whenComplete(
                              () => Get.to(
                                Home(),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ?',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScr(),
                              ));
                        },
                        child: Text(
                          '  Sign In',
                          style: TextStyle(fontSize: 17, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
