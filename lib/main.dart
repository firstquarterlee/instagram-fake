import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      iconTheme: IconThemeData(color: Colors.blue),
      appBarTheme: AppBarTheme(
        color: Colors.grey,
        actionsIconTheme: IconThemeData(color: Colors.blue),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.red),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
      ),

    ), //
    home: MyApp(),
  ));
}

var a = TextStyle();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0; //현재 탭의 모습 //홈0, 샵1

  getData() async {
    var result =  await http.get(Uri.parse('https://codingapple1.github.io/app/data.json')); //get요청함
    var result2 = jsonDecode(result.body);
    print(result2);
  }

  @override
  void initState()  {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Instagram'),
            Icon(Icons.add_box_outlined),
          ],
        ),
      ),
      body: [Home(), Text('홈페이지'), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ],
      ),

    );
  }
}

//커스텀위젯
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 3, itemBuilder: (c, i){
      return Column(
        children: [
          Image.network('https://codingapple1.github.io/kona.jpg'),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('좋아요 100'),
                Text('글쓴이'),
                Text('글내용'),
              ],
            ),
          )
        ],
      );
    });

  }
}
