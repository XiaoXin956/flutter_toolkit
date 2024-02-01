import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/rested/three_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("返回")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("SecondPage"),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          children: [
            const Center(
              child: Text("SecondPage"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ThreePage();
                  }));
                },
                child: const Text("下一页")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("返回")),
          ],
        ),
      ),
    );
  }
}
