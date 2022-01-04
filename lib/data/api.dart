import 'dart:convert';
import 'package:flutter_clean_architecture/model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '24999262-d78d2a61a8beebcf2664f2cde';

  //http 통신 코드 비동기 처리 필요하기 때문에 Future
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(
        Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));
    //Map으로 가져와서 json 형태로 사용
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //같은 형태가 반복되는 타입이라 Iterable 타입으로 표현
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
