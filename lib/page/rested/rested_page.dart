import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/rested/all_page.dart';

class RestedPage extends StatefulWidget {
  const RestedPage({super.key});

  @override
  State<RestedPage> createState() => _RestedPageState();
}

class _RestedPageState extends State<RestedPage> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 路由嵌套
            Container(
              color: Colors.blue,
              height: 300,
              child: Navigator(
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute(builder: (BuildContext context) {
                    return AllPage(buildContext:buildContext);
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
