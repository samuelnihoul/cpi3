import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/appBar.dart';
import 'package:provider/provider.dart';
// the dashboard for the user. Greets the user. Also has a button to sign out. Contains buttons to view certificates and to scan certificates. Also a QR code generator.

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    return Container(
      child: Scaffold(
        appBar: ApppBar(),
        body: Center(
          child: Column(
            children: [
              Text('🌞 ${user!.displayName??'guest'} 🌞'),
              ElevatedButton(
                child: Text('My Certificates'),
                onPressed: () => Navigator.pushNamed(context, '/certificates'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class myCertificates extends StatefulWidget {
  myCertificates({Key? key}) : super(key: key);

  @override
  State<myCertificates> createState() => myCertificatesState();
}

class myCertificatesState extends State<myCertificates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApppBar(),
      body: Center(
        child: Column(
          children: [
            Text('🌞 My Certificates 🌞'),
            ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Certificate 1'),
                  subtitle: Text('This is a certificate'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/certificate1');
                  },
                ),
                ListTile(
                  title: Text('Certificate 2'),
                  subtitle: Text('This is a certificate'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/certificate2');
                  },
                ),
                ListTile(
                  title: Text('Certificate 3'),
                  subtitle: Text('This is a certificate'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/certificate3');
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
