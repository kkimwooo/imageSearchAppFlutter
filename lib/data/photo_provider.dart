import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/api.dart';
import 'package:flutter_clean_architecture/model/photo.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;
  //Stream 관리를 위한 위해 StreamController를 사용한다.
  //'..' 사용하면 add와 같이 void를 return 하는 함수를 사용해서 객체의 레퍼런스를 반환한다.
  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  //PhotoProvider를 static으로 만들어서 어디서든 호출할수 있도록
  //context는 Widget Tree 정보를 갖고 있는 객체
  static PhotoProvider of(BuildContext context) {
    //Widget Tree에서 가장 가까운 PhotoProvider를 찾아서 반환
    final PhotoProvider? result =
        context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    //assert 만약 result가 null이면 에러를 발생시킨다.
    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamController.add(result);
  }

  //Widget이 변경이 되면 자동으로 호출되는 함수
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    //oldWidget(이전 상태)와 api 가 다르면 true를 반환 = 바뀌었다는 것을 알려줌
    return oldWidget.api != api;
  }
}
