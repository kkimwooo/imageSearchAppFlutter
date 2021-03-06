import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/pixabay_api.dart';
import 'package:flutter_clean_architecture/ui/home_screen.dart';
import 'package:flutter_clean_architecture/ui/home_view_model.dart';
import 'package:provider/provider.dart';

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
      home: Provider(
          create: (_) => HomeViewModel(
                PixabayApi(),
              ),
          child: const HomeScreen()),
    );
  }
}
