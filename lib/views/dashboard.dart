import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/appBar.dart';
import 'package:provider/provider.dart';
// the dashboard for the user. Greets the user. Also has a button to sign out. Contains buttons to view certificates and to scan certificates. Also a QR code generator.

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    return Container(
      child: Scaffold(
        appBar: const ApppBar(),
        body: Center(
          child: Column(
            children: [
              Text('🌞 ${user!.displayName??'guest'} ✨'),
              ElevatedButton(
                child: const Text('My Certificates'),
                onPressed: () => Navigator.pushNamed(context, '/certificates'),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class myCertificates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('🌞 My Certificates ✨'),
            ListView(
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
