import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/api.dart';
import 'package:flutter_clean_architecture/data/photo_provider.dart';
import 'package:flutter_clean_architecture/ui/home_screen.dart';
import 'package:flutter_clean_architecture/ui/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoProvider(
          viewModel: HomeViewModel(
            PixabayApi(),
          ),
          child: const HomeScreen()),
    );
  }
}
