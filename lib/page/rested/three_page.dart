

import 'package:flutter/material.dart';

class ThreePage extends StatefulWidget {
  const ThreePage({super.key});

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
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
        title: Text("ThreePage"),
      ),
      body: PopScope(
        onPopInvoked: (v){
          print(v);
        },
        child: Container(
          color: Colors.blueAccent,
          child: Column(
            children: [
              const Center(
                child: Text("ThreePage"),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("返回")),
            ],
          ),
        ),
      ),
    );
  }
}
