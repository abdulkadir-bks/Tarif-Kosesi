import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/yemekler/balik.dart';
import 'package:flutter_application_2/yemekler/corba.dart';
import 'package:flutter_application_2/yemekler/icecek.dart';
import 'package:flutter_application_2/yemekler/salata.dart';
import 'package:flutter_application_2/yemekler/tatli.dart';
import 'package:flutter_application_2/yemekler/yemek.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  void navigateToYemekPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YemekPage()),
    );
    // Navigator push metodunu kullanarak YemekPage'e geçiş yapılacak.
  }

  void navigateToTatliPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TatliPage()),
    );
    // Navigator push metodunu kullanarak TatliPage'e geçiş yapılacak.
  }

  void navigateToMezePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MezePage()),
    );
    // Navigator push metodunu kullanarak SalataPage'e geçiş yapılacak.
  }

  void navigateToIcecekPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IcecekPage()),
    );
    // Navigator push metodunu kullanarak IcecekPage'e geçiş yapılacak.
  }

  void navigateToBalikPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BalikPage()),
    );
    // Navigator push metodunu kullanarak BalikPage'e geçiş yapılacak.
  }

  void navigateToCorbaPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CorbaPage()),
    );
    // Navigator push metodunu kullanarak CorbaPage'e geçiş yapılacak.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 109, 109),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Diğer widget'lar
              ],
            ),
          ),
          Positioned(
            bottom: 500.0,
            right: 220.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/Yemek.jpeg",
                  onPressed: () {
                    navigateToYemekPage(context);
                  },
                ),
                Text(
                  'Yemekler',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 300.0,
            right: 220.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/tatlı.jpeg",
                  onPressed: () {
                    navigateToTatliPage(context);
                  },
                ),
                Text(
                  'Tatlılar',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 85.0,
            right: 220.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/salata.jpeg",
                  onPressed: () {
                    navigateToMezePage(context);
                  },
                ),
                Text(
                  'Mezeler',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 300.0,
            right: 18.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/icecek.jpeg",
                  onPressed: () {
                    navigateToIcecekPage(context);
                  },
                ),
                Text(
                  'İçecekler',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 85.0,
            right: 20.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/fish.jpeg",
                  onPressed: () {
                    navigateToBalikPage(context);
                  },
                ),
                Text(
                  'Balıklar',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 500.0,
            right: 20.0,
            child: Column(
              children: [
                ImageButton(
                  imagePath: "assets/corba.jpeg",
                  onPressed: () {
                    navigateToCorbaPage(context);
                  },
                ),
                Text(
                  'Çorbalar',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 65.0,
            left: 20.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tarif Köşesi',
                style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Courgette',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const ImageButton({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          width: 150.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
