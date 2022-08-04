import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/appBar.dart';
// the dashboard for the user. Greets the user.

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  
  @override
  Widget build(BuildContext context) {
    final username =  ModalRoute.of(context)!.settings.arguments as UserCredential;
    return Container(


      child: Scaffold(
        appBar: ApppBar(),
        body: Center(
          child: Text('Welcome ${username.user!.displayName}'),
        ),
      ),
    );
  
  }
}
