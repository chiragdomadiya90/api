import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePlus extends StatefulWidget {
  const SharePlus({Key? key}) : super(key: key);

  @override
  State<SharePlus> createState() => _SharePlusState();
}

class _SharePlusState extends State<SharePlus> {
  final message = TextEditingController();
  final url = "https://www.youtube.com/watch?v=sacCKuT3WuE";
  var image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7b-toouYIscVGfV-aJq-Xx_vgPF0sOM6afw&usqp=CAU";

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Files'),
      ),
      backgroundColor: Colors.amber.withOpacity(0.7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 55,
              ),
              TextFormField(
                controller: message,
                decoration: InputDecoration(
                  hintText: "Enter a Message",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (message.value.text.isNotEmpty) {
                    await Share.share("${message.text},$url");
                  }
                },
                child: const Text("Share a Text"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(height: 100, width: 100, child: Image.network("$image")),
              const SizedBox(
                height: 55,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(image);
                    final res = await http.get(uri);
                    final bytes = res.bodyBytes;

                    final temp = await getTemporaryDirectory();
                    final path = "${temp.path}/image.jpg";
                    File(path).writeAsBytesSync(bytes);

                    await Share.shareFiles([path]);
                  },
                  child: Text("Share NetImage")),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Choose any One"),
                        actions: [
                          IconButton(
                              onPressed: () async {
                                final image = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (image != null) {
                                  await Share.shareFiles([image.path]);
                                }
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera_alt)),
                          IconButton(
                              onPressed: () async {
                                final image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  await Share.shareFiles([image.path]);
                                }
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.photo)),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Share Image"),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  final image =
                      await picker.pickVideo(source: ImageSource.gallery);
                  if (image != null) {
                    await Share.shareFiles([image.path]);
                  }
                },
                child: const Text("Share Video"),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);

                  List<String>? files =
                      result!.files.map((e) => e.path).cast<String>().toList();
                  if (files != null) {
                    await Share.shareFiles(files);
                  }
                },
                child: const Text("Share File"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
