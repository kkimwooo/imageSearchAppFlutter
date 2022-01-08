import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/ui/home_view_model.dart';

class PhotoProvider extends InheritedWidget {
  final HomeViewModel viewModel;

  const PhotoProvider({
    Key? key,
    required this.viewModel,
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

  //Widget이 변경이 되면 자동으로 호출되는 함수
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return true;
  }
}
