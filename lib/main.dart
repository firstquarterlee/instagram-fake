import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        // 이제 모든 아이콘은 파래짐 -> 아이콘마다 색상을 안줘도됨(장점)
        iconTheme: IconThemeData(color: Colors.blue),
        // 앱바 모두 회색됨
        appBarTheme: AppBarTheme(
            color: Colors.grey,
            actionsIconTheme: IconThemeData(color: Colors.blue)),
        textTheme: TextTheme(
          //bodyText2 == bodyMedium -> 이건 Text()위젯 스타일을 결정하는 방법
          bodyMedium: TextStyle(color: Colors.red)
        ),
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
          onPressed: (){},
          iconSize: 30,
          )
        ],
      ),
      body: Text('안녕'),
    );
  }
}
