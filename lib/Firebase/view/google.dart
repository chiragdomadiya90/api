import 'package:api/Firebase/firebase_service/google_auth_service.dart';
import 'package:api/Firebase/view/sign_up_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Google extends StatelessWidget {
  const Google({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Sign In with Google',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          )),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences remove = await SharedPreferences.getInstance();
              signOutGoogle().whenComplete(
                () => remove.remove('Email').then(
                      (value) => Get.to(
                        SignUp(),
                      ),
                    ),
              );
            },
            child: Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text('LogOut',
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
