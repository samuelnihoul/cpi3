import '../components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:download/download.dart';
import 'package:file/local.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cross_file/cross_file.dart';

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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('uploading...')));
          // Upload file
          TaskSnapshot task = await FirebaseStorage.instance
              .ref()
              .child('/${user?.displayName}/$fileName')
              .putData(fileBytes ?? Uint8List(0));
          print(task.bytesTransferred);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('success 😊'), backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('no file selected 😉'),
                backgroundColor: Colors.red),
          );
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
    var user = Provider.of<User?>(context);
    return Scaffold(
      appBar: const ApppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('🌞 My Certificates ✨'),
            Uploader(),
            StreamBuilder<ListResult>(
                stream: listAllPaginated(FirebaseStorage.instance
                    .ref()
                    .child('/${user?.displayName}')),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error ${snapshot.error} ${snapshot.data}');
                  } else if (snapshot.hasData) {
                    final products = snapshot.data!;
                    return ListView(
                        shrinkWrap: true,
                        children: products.items
                            .map((e) =>
                                buildDocument(e, user?.displayName ?? ''))
                            .toList());
                  } else
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                }))
          ],
        ),
      ),
    );
  }
}

Stream<ListResult> listAllPaginated(Reference storageRef) async* {
  String? pageToken;
  do {
    final listResult = await storageRef.list(ListOptions(
      maxResults: 100,
      pageToken: pageToken,
    ));
    yield listResult;
    pageToken = listResult.nextPageToken;
  } while (pageToken != null);
}

Widget buildDocument(Reference product, String user) => ListTile(
    title: Text(product.name),

    //download the document
    onTap: () => download(product.name, user));

download(String fileName, String displayName) async {
  final islandRef =
      FirebaseStorage.instance.ref().child('/$displayName/$fileName').fullPath;

  final x = XFile(islandRef);
  x.saveTo('/');
}
