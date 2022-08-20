import '../components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Uploader extends StatelessWidget {
  const Uploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilePickerResult? file;
    var user = Provider.of<User?>(context);
    return ElevatedButton(
      onPressed: () async {
        file = await FilePicker.platform.pickFiles();

        if (file != null) {
          Uint8List? fileBytes = file!.files.first.bytes;
          String fileName = file!.files.first.name;

          // Upload file
          TaskSnapshot task = await FirebaseStorage.instance
              .ref()
              .child('/${user?.displayName}/$fileName')
              .putData(fileBytes ?? Uint8List(0));
          print(task.bytesTransferred);
          SnackBar(content: Text('success 😊'));
        } else {
          SnackBar(content: Text('no file selected 😉'));
        }
      },
      child: Text(
          'Upload'), /* style: ButtonStyle(shape: MaterialStateProperty()), */
    );
  }
}

class MyCertificates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('🌞 My Certificates ✨'),
            Uploader(),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: const Text('Certificate 1'),
                  subtitle: const Text('This is a certificate'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  title: const Text('Certificate 2'),
                  subtitle: const Text('This is a certificate'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  title: const Text('Certificate 3'),
                  subtitle: const Text('This is a certificate'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
