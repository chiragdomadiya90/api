import 'package:flutter/material.dart';

class url_launcherr extends StatelessWidget {
  const url_launcherr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Launch URL'))
          ],
        ),
      ),
    );
  }
}
