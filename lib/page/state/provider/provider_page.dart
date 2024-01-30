import 'package:flutter/material.dart';
import 'package:flutter_toolkit/page/state/provider/count_provider.dart';
import 'package:provider/provider.dart';

/// provider 的使用
class ProviderPage extends StatefulWidget {
  const ProviderPage({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProviderPage(),
    );
  }

  Widget _ProviderPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<CountProvider>(builder: (BuildContext context, value, Widget? child) {
          return Text("${value.count}");
        },),
        TextButton(
            onPressed: () {
              context.read<CountProvider>().increment();
            },
            child: Text("点击")),
      ],
    );
  }
}
