import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/service/repository.dart';
import 'package:image_picker/image_picker.dart';

class EklemePage extends StatefulWidget {
  @override
  _EklemePageState createState() => _EklemePageState();
}

class _EklemePageState extends State<EklemePage> {
  String imageUrl = '';
  String caption = '';
  String ingredients = '';
  String recipe = '';
  String? selectedCategory; // Seçilen kategori değişkeni
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();

  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageUrl = pickedFile.path;
      } else {
        print('Galeriden resim seçilmedi.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekleme Sayfası'),
      ),
      backgroundColor: Color.fromARGB(255, 197, 109, 109),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _getImageFromGallery,
                child: Text('Galeriden Resim Seç'),
              ),
              SizedBox(height: 50),
              imageUrl.isNotEmpty
                  ? Image.file(
                      File(imageUrl),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(), // Seçilen resmin önizlemesi
              SizedBox(height: 5),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  labelText: 'Yemek İsmi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    caption = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _materialController,
                decoration: InputDecoration(
                  labelText: 'Malzemeler',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    ingredients = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _recipeController,
                  decoration: InputDecoration(
                    labelText: 'Yemek Tarifi',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  ),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      recipe = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                hint: Text(
                  'Yemeğin Kategorisi',
                  style: TextStyle(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                  ),
                ), // İlk başta gösterilecek metin
                value: selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: <String>[
                  'Yemekler',
                  'Corbalar',
                  'Tatlılılar',
                  'İçecekler',
                  'Mezeler',
                  'Balıklar',
                  // Buraya istediğiniz kadar kategori ekleyebilirsiniz
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_foodNameController.text.isNotEmpty &&
                      _materialController.text.isNotEmpty &&
                      _recipeController.text.isNotEmpty &&
                      imageUrl.isNotEmpty &&
                      selectedCategory!.isNotEmpty) {
                    setState(() {
                      FoodRepository().foodadd(
                          _recipeController.text,
                          _materialController.text,
                          _foodNameController.text,
                          selectedCategory!,
                          imageUrl);
                      Navigator.pop(context);
                    });
                  } else {
                    print('bir hata oluştu');
                  }
                },
                child: Text('Ekle'),
              ),
              SizedBox(
                  height:
                      200), // Klavye kapatıldığında içeriği aşağı kaydırmak için boşluk eklendi
            ],
          ),
        ),
      ),
    );
  }
}
