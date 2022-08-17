import '../components/appBar.dart';
import 'package:flutter/material.dart';

class Uploader extends StatelessWidget {
  const Uploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ()=>print('hello'), child: Text('Upload'));
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
