import 'package:api/Localization/messege.dart';
import 'package:api/create_user.dart';
import 'package:api/share_plus/share_pluss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'Firebase/insert-update_delete/add_products.dart';
import 'dart:io';

import 'Firebase/insert-update_delete/hive_ins_up_del.dart';
import 'Getx/Getx_Api/home_scr.dart';
import 'Localization/localization_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<String>('addCart');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          translations: Message(),
          locale: Locale('hi', 'IN'),
          fallbackLocale: Locale('hi', 'IN'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: SharePlus());
    });
  }
}
