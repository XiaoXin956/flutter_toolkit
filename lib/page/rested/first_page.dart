

import 'package:flutter/material.dart';
import 'package:flutter_toolkit/main.dart';
import 'package:flutter_toolkit/page/rested/second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("FirstPage"),
      ),
      body: Container(
        color: Colors.red,
        child:  Column(
          children: [
            Center(
              child: Text("FirstPage1231"),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SecondPage();
              }));
            }, child: Text("下一个页面")),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return HomePage(title: '',);
              }));
            }, child: Text("首页")),
          ],
        ),
      ),
    );
  }
}
