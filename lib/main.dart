import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/rendering.dart'; //스크롤 관련 유용한 함수들 들어있음

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
  var data = [];

  getData() async {
    var result =  await http.get(Uri.parse('https://codingapple1.github.io/app/data.json')); //get요청함
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
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
      body: [Home(data: data), Text('홈페이지'), Text('샵페이지')][tab],
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
class Home extends StatefulWidget {
  const Home({super.key, this.data});

  final data;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener((){
      //print(scroll.position.pixels); //현재 스크롤 위치 알려줌
      //print(scroll.position.maxScrollExtent); //최대 스크롤 가능한 길이 알려줌
      //print(scroll.position.userScrollDirection); //위치 알려줌 위, 아래
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        //맨 밑까지 왔을 때 알려줌 // 스크롤한 거리 == 최대 스크롤 거리
        print('같음');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(itemCount: 3, controller: scroll, itemBuilder: (c, i){
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
                  Image.network(widget.data[i]['image']),
                  Text('좋아요 ${widget.data[i]['likes']}개'),
                  Text(widget.data[i]['date']),
                  Text(widget.data[i]['content']),
                ],
              ),
            )
          ],
        );
      });
    } else {
      return CircularProgressIndicator();

    }

  }
}
