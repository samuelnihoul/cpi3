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
        } else {
          print('No file selected');
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
                        children: products.items.map(buildDocument).toList());
                  } else
                    return Center(child: CircularProgressIndicator());
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

Widget buildDocument(Reference product) => ListTile(
      title: Text(product.name),
    );
