//the about page
import 'package:flutter/material.dart';
import '../components/appBar.dart';
import 'package:bubble/bubble.dart';

class Bout extends StatelessWidget {
  const Bout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApppBar(),
      body: Bubble(
        child: Text('''
      This initiative is a voluntary climate pass that aims to become a global standard. Alike sanitary passes,
      this one is a way to make a difference in the world: it will be a proof of carbon offsets for inbound trips.
      Therefore, most facilities, organizations and individuals will be able to benefit from this initiative through requiring it and thus showing their commitment to the cause.
      
        '''),
      ),
    );
  }
}
