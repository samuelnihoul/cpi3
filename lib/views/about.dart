//the about page
import 'package:flutter/material.dart';
import '../components/appBar.dart';

class Bout extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApppBar(),
      body: const Text('''



      Karbon Moneta is a proof of carbon removal currency: we icentivize people to remove GreenHouse Gases (GHGs) from the atmosphere.
      Every block time (or equivalent), we mint a token to be attributed to the best carbon removal contributors, in select carbon removal projects. Most notably, we integrate with harmonia-eko's Karbon Basar, the NFT carbon offset marketplace.
      Specifically, every 0.1 tonne of carbon removal will give you one chance of winning the token. 
      '''
),
    );
  }
  
}