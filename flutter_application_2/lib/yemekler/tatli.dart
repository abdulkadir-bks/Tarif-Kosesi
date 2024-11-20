import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ekleme.dart';
import 'package:flutter_application_2/service/repository.dart';

class TatliPage extends StatefulWidget {
  @override
  _CorbaPageState createState() => _CorbaPageState();
}

class _CorbaPageState extends State<TatliPage> {
  final FoodRepository _foodRepository = FoodRepository();
  late Future<List<Map<String, dynamic>>> _foodList;

  @override
  void initState() {
    super.initState();
    _loadFoodList();
  }

  Future<void> _loadFoodList() async {
    setState(() {
      _foodList = _foodRepository.getfood();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 0, 620),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EklemePage()),
              );
              // Yeni bir şey eklemek için yapılacak işlem buraya yazılabilir.
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 197, 109, 109),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _foodList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> foodList = snapshot.data!;
            List<Map<String, dynamic>> filteredFoodList = foodList
                .where((food) => food['kategori'] == 'Tatlılar')
                .toList();
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: filteredFoodList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> foodData = filteredFoodList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Image.network(foodData['foto']),
                      subtitle: Text(foodData['isim']),
                    ),
                    Text(
                      foodData['kategori'],
                    ),
                    Text("malzeme: ${foodData['malzeme']}"),
                    Text(foodData['tarif']),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildImage(
      BuildContext context, String imagePath, String imageDescription) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Image.network(
                imagePath,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 1,
                width: 10,
              ),
              Text(
                imageDescription,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
