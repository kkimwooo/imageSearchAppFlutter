import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/api.dart';
import 'package:flutter_clean_architecture/data/photo_provider.dart';
import 'package:flutter_clean_architecture/model/photo.dart';
import 'package:flutter_clean_architecture/ui/widget/photo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  List<Photo> _photos = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = PhotoProvider.of(context);
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
                    final photos =
                        await photoProvider.api.fetch(_controller.text);
                    //State 변경이 일어나고 화면 새로 그려야 하므로 setState 사용
                    setState(() {
                      _photos = photos;
                    });
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
