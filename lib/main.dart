import 'package:flutter/material.dart';
import 'components/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/dashboard.dart';
import 'views/about.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        
        '/dashboard': (context) => Dashboard(),
        '/about': (context) => const Bout(),
      },
      title: 'Climate Pass 🛂',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: const MaterialColor(700, {
                1: Colors.black,
                700: Color(0xffffd700),
                200: Color(0xffffd700)
              }),
              brightness: Brightness.light)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/roadmap.jpg'), fit: BoxFit.fitHeight),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Welcome!", style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  child: const Text('login with Google',
                      style: TextStyle(color: Colors.white)),
                  onPressed:  ()async {
                    final UserCredential user = await signInWithGoogle();
                    Navigator.pushNamed(
                      
                      context, '/dashboard',
                      arguments: 
  user
                      )
                      ;},
                  ),
                
                ElevatedButton(
                  child: const Text('register with Google',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => {
                    Navigator.pushNamed(context,'/dashboard',arguments:signInWithGoogle())
                    },
                )
              ]),
        ),
      ),
    );
  }
}
