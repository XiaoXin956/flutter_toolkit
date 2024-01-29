import 'package:flutter/material.dart';

class SidesDataView extends StatefulWidget {

  List<String> data = [];
  double fontSize =16;
  double itemHeight = 50;

  SidesDataView({super.key,required this.data,required this.fontSize,required this.itemHeight,});

  @override
  State<SidesDataView> createState() => _SidesDataState();
}

class _SidesDataState extends State<SidesDataView> {

  


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
