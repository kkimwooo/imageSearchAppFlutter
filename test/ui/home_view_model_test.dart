import 'package:flutter_clean_architecture/data/photo_api_repository.dart';
import 'package:flutter_clean_architecture/model/photo.dart';
import 'package:flutter_clean_architecture/ui/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Stream 동작', () async {
    //Test 할때 PixabayAPI의 동작 여부에 따라 테스트 결과 바뀜
    //따라서 인터페이스 사용
    final viewModel = HomeViewModel(FakePhotoApiRepository());
    await viewModel.fetch('apple');

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();
    expect(
      viewModel.photoStream,
      emitsInOrder([
        equals([]),
        equals(result),
      ]),
    );
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<List<Photo>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));
    return fakeJson.map((e) => Photo.fromJson(e)).toList();
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 887443,
    "pageURL":
        "https://pixabay.com/photos/flower-life-yellow-flower-crack-887443/",
    "type": "photo",
    "tags": "flower, life, yellow flower",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/08/13/20/06/flower-887443_150.jpg",
    "previewWidth": 150,
    "previewHeight": 116,
    "webformatURL":
        "https://pixabay.com/get/g2d3ed43398fa2f3db04b5fc20da04e5b627cd99c33f863b2a505fa1edcd120383b80b4df7c34709834a2a09379fe7955_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 497,
    "largeImageURL":
        "https://pixabay.com/get/gf20214ffa3b8b27352383f4395e810896c0ec706fe3fbf386f4424f0ac025420b709a07b7d78796b2d6b8a09c4cff2328e915f8fc8e20956415201cbbefc7858_1280.jpg",
    "imageWidth": 3867,
    "imageHeight": 3005,
    "imageSize": 2611531,
    "views": 257082,
    "downloads": 152366,
    "collections": 3190,
    "likes": 1012,
    "comments": 162,
    "user_id": 1298145,
    "user": "klimkin",
    "userImageURL":
        "https://cdn.pixabay.com/user/2017/07/18/13-46-18-393_250x250.jpg"
  },
  {
    "id": 3063284,
    "pageURL":
        "https://pixabay.com/photos/rose-flower-petal-floral-noble-3063284/",
    "type": "photo",
    "tags": "rose, flower, petal",
    "previewURL":
        "https://cdn.pixabay.com/photo/2018/01/05/16/24/rose-3063284_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g41a37dbadcbcd510382acee44238550cc44db674057b62677858f4c1225a697ec12910b84b24628d24518077aebd955ecaafd520983d3bdcbf55d1b649c1d4bb_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g2fb174e165d445b9eb2e319f890f4299162639f45b859fc09dae7d74a12e83a82898a2358aed1d73b94ced151ac80507770ef837d7fd7ce0ab0f46dedd2216c1_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 3574625,
    "views": 930651,
    "downloads": 599921,
    "collections": 2691,
    "likes": 1418,
    "comments": 305,
    "user_id": 1564471,
    "user": "anncapictures",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/11/27/06-58-54-609_250x250.jpg"
  },
];
