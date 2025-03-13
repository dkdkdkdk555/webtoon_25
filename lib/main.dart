import 'package:flutter/material.dart';
import 'package:webtoon_25/view/webtoon_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("오늘의 웹툰"
              ,textAlign: TextAlign.center
              ,style: TextStyle(
                color: Color.fromARGB(255, 64, 162, 64),
                fontWeight: FontWeight.w900,
              ),
            ),
          backgroundColor: const Color(0xFFF1F0F7),
        ),
        body: const WebtoonList()
      ),
    );
  }
}