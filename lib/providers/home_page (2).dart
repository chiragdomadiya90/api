import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_controller.dart';

class Provider_demoo extends StatefulWidget {
  @override
  _Provider_demooState createState() => _Provider_demooState();
}

class _Provider_demooState extends State<Provider_demoo> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterController>(context, listen: false);
    print("Build Called");
    return Scaffold(
      appBar: AppBar(
        title: Text('Providers Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterController>(
              builder: (context, value, child) {
                return Text(
                  '${provider.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              provider.incrementCounter();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              provider.decrementCounter();
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              provider.resetCounter();
            },
            tooltip: 'Reset',
            child: Icon(Icons.refresh),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
