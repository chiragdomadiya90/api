import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'create_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: Create_User());
    });
  }
}
