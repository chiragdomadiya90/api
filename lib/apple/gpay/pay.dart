import 'package:api/apple/gpay/pay2.dart';
import 'package:flutter/material.dart';

dynamic amount;

class Pays extends StatefulWidget {
  const Pays({Key? key}) : super(key: key);

  @override
  State<Pays> createState() => _PaysState();
}

class _PaysState extends State<Pays> {
  @override
  var prices = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: prices,
            decoration: const InputDecoration(hintText: "Enter a amount"),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  amount = prices.text;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pays2(),
                    ));
              },
              child: const Text("Pay"))
        ]),
      )),
    );
  }
}
