import 'package:api/Localization/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_controller.dart';

class LocalizationScreen extends StatefulWidget {
  const LocalizationScreen({Key? key}) : super(key: key);

  @override
  State<LocalizationScreen> createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  MyController myController = Get.put(MyController());
  List language = ['Hindi', 'English', 'France'];
  dynamic choose = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.language),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: choose,
              items: language
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(
                  () {
                    choose = value;
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (choose == 'Hindi') {
                  myController.changeLanguage('hi', 'IN');
                } else {
                  myController.changeLanguage('fr', 'FR');
                }
                Get.to(() => SecondScreen());
              },
              child: Text(
                'Done',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
