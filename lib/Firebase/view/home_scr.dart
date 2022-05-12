import 'package:api/Firebase/firebase_service/firebase_auth_service.dart';
import 'package:api/Firebase/view/sign_up_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Userdata',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          )),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuthServices.logOut().whenComplete(() => Get.to(
                    () => SignUp(),
                  ));
            },
            child: Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
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
