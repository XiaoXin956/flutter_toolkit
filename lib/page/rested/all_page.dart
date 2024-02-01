import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/rested/first_page.dart';

class AllPage extends StatefulWidget {

  BuildContext buildContext;

  AllPage({super.key,required this.buildContext});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(widget.buildContext);
            },
            child: Text("返回")),
        title: Text('All'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('All'),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FirstPage();
                }));
              },
              child: Text("跳转到1")),
          TextButton(
              onPressed: () {
                Navigator.pop(widget.buildContext);
              },
              child: Text("退出")),
        ],
      ),
    );
  }
}
