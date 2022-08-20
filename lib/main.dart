import 'package:flutter/material.dart';
import 'components/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/dashboard.dart';
import 'views/about.dart';
import 'package:provider/provider.dart';
import 'views/myCertificates.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        routes: {
          '/certificates': (context) => MyCertificates(),
          '/dashboard': (context) => Dashboard(),
          '/about': (context) => const Bout(),
        },
        title: 'Klima Pas 🛂',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: const MaterialColor(700, {
                  1: Colors.black,
                  700: Color(0xffffd700),
                  200: Color(0xffffd700)
                }),
                brightness: Brightness.light)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/roadmap.jpg'), fit: BoxFit.fitHeight),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Center(
            child: Column(children: <Widget>[
              const Text("🙋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const Text('maybe enable popups if auth fails'),
              GoogleAuthButton(
                onPressed: () async {
                  await signInWithGoogle();
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
