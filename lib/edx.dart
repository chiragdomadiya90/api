import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final taskName = TextEditingController();
  final keyName = TextEditingController();

  Box<String>? todoBox;

  @override
  void initState() {
    todoBox = Hive.box<String>('todo');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text("Add Task"),
                    TextFormField(
                      controller: taskName,
                      decoration: InputDecoration(hintText: "Task Name"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        await todoBox!
                            .put("${Random().nextInt(1000)}", taskName.text);
                        Navigator.pop(context);

                        taskName.clear();
                      },
                      child: const Text("Add")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox!.listenable(),
        builder: (context, Box<String> todos, _) {
          return ListView.builder(
            itemCount: todos.keys.length,
            itemBuilder: (context, index) {
              final key = todos.keys.toList()[index];
              final value = todos.get(key);
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text("Update Task"),
                                  TextFormField(
                                    controller: taskName,
                                    decoration:
                                        InputDecoration(hintText: "Task Name"),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await todoBox!.put("$key", taskName.text);
                                      Navigator.pop(context);

                                      taskName.clear();
                                    },
                                    child: const Text("Update")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () async {
                          await todoBox!.delete(key);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                title: Text(value!),
                //subtitle: Text(key!),
              );
            },
          );
        },
      ),
    );
  }
}
