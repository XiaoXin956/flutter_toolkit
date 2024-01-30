

import 'package:flutter/material.dart';

import 'bloc/bloc_pge.dart';
import 'provider/provider_page.dart';

class StateAllPage extends StatefulWidget {
  const StateAllPage({super.key});

  @override
  State<StateAllPage> createState() => _StateAllPageState();
}

class _StateAllPageState extends State<StateAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理"),
      ),
      body: Column(
        children: [

          // 1. provider
          TextButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return ProviderPage();
                }));
          }, child: Text("provider")),
          TextButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return BlocPage();
                }));
          }, child: Text("BlocPage")),

        ],
      ),
    );
  }
}
