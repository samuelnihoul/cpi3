import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/appBar.dart';
import 'package:provider/provider.dart';
import './myCertificates.dart';
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
              Text('🌞 ${user!.displayName} ✨'),
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
