import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../views/about.dart';
import '../main.dart';
class ApppBar extends StatelessWidget implements PreferredSizeWidget {
  const ApppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:TextButton(
        child: const Text('Climate Pass 🛂', style: const TextStyle(color: Colors.white)),
      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),)),),
      actions: [
        TextButton(
          child: const Text('contact us', style: TextStyle(color: Colors.white)),
          onPressed: () =>
              _launchUrl(Uri(
                scheme:'mailto',
                path:'samuel@harmonia-eko.ooo',

                )),
        ),
        TextButton(
          child: const Text('about', style: const TextStyle(color: Colors.white)),
          //links to /about
onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Bout(),)),
        ),
        
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
