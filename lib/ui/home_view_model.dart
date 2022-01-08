import 'dart:async';
import 'package:flutter_clean_architecture/data/photo_api_repository.dart';
import 'package:flutter_clean_architecture/model/photo.dart';

// PixabayApi를 가지고 처리
class HomeViewModel {
  final PhotoApiRepository repository;

  HomeViewModel(this.repository);

  //Stream 관리를 위한 위해 StreamController를 사용한다.
  //'..' 사용하면 add와 같이 void를 return 하는 함수를 사용해서 객체의 레퍼런스를 반환한다.
  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photoStreamController.add(result);
  }
}
