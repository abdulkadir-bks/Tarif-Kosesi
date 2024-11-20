import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FoodRepository {
  final foodcolection = FirebaseFirestore.instance.collection('food');
  Future<void> foodadd(String tarif, String malzeme, String isim,
      String kategori, String foto) async {
    try {
      File imageFile = File(foto);
      DocumentReference newFoodRef = foodcolection.doc();
      Map<String, dynamic> foodData = {
        'foto': foto,
        'isim': isim,
        'malzeme': malzeme,
        'tarif': tarif,
        'kategori': kategori,
      };
      await newFoodRef.set(foodData);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('FoodPhoto/${isim}foodPhoto_lead');
      await firebaseStorageRef.putFile(imageFile);
      String url = await firebaseStorageRef.getDownloadURL();

      await newFoodRef.update({
        'foto': url,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getfood() async {
    try {
      QuerySnapshot foodSnapshot = await foodcolection.get();

      List<Map<String, dynamic>> foods = [];

      foodSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> foodData = document.data() as Map<String, dynamic>;
        foods.add(foodData);
      });

      return foods;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
