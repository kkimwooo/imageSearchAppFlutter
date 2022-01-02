import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/model/photo.dart';
import 'package:flutter_clean_architecture/ui/widget/photo_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  List<Photo> _photos = [];

  //http 통신 코드 비동기 처리 필요하기 때문에 Future
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=24999262-d78d2a61a8beebcf2664f2cde&q=$query&image_type=photo&pretty=true'));
    print('response.statusCode : ' + response.statusCode.toString());
    //Map으로 가져와서 json 형태로 사용
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //같은 형태가 반복되는 타입이라 Iterable 타입으로 표현
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                suffixIcon: IconButton(
                  //onPressed 안에서 사용할 함수가 async await 이기 때문에 여기서도 async await선언
                  onPressed: () async {
                    final photos = await fetch(_controller.text);
                    //State 변경이 일어나고 화면 새로 그려야 하므로 setState 사용
                    setState(() {
                      _photos = photos;
                    });
                    print(_photos.toString());
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          //Column 안에 정해지지 않은 사이즈의 위젯이 들어오면 오류 발생
          //그래서 Expanded 위젯을 사용하여 사이즈를 정해준다.
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _photos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final photo = _photos[index];
                  return PhotoWidget(
                    photo: photo,
                  );
                }),
          )
        ],
      ),
    );
  }
}
