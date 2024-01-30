

import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/state/bloc/count/count_view.dart';

class BlocPage extends StatefulWidget {
  const BlocPage({super.key});

  @override
  State<BlocPage> createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用
            CountPage(),

          ],
        ),
      ),
    );
  }
}
