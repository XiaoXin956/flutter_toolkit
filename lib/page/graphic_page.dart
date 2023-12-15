import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import 'data.dart';

const lineData = [
  {"date": "2005", "name": "person", "points": 200.0},
  {"date": "2010", "name": "person", "points": 200.0},
  {"date": "2015", "name": "person", "points": 300.0},
  {"date": "2020", "name": "person", "points": 400.0},
  {"date": "2025", "name": "person", "points": 500.0},
  // {"data": "2005", "name": "food", "points": 500},
  // {"data": "2010", "name": "food", "points": 700},
  // {"data": "2015", "name": "food", "points": 900},
  // {"data": "2020", "name": "food", "points": 890},
  // {"date": "2025", "name": "food", "points": 700},
];

class GraphicPage extends StatefulWidget {
  const GraphicPage({super.key});

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            lineAre(),
          ],
        ),
      ),
    );
  }

  Widget lineAre() {
    return Column(
      children: [
        Text("线性"),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 350,
          height: 300,
          child: Chart(
            data: basicData,
            // 根据给定线条数据的name值相同的为同一条线
            variables: {
              'genre': Variable(
                accessor: (Map map) => map['genre'] as String,
              ),
              'sold': Variable(
                accessor: (Map map) => (map['sold'] ?? double.nan) as num,
              ),
            },
            coord: RectCoord(horizontalRange: [0.1, 0.99]),
            marks: [
              IntervalMark(
                label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
                elevation: ElevationEncode(value: 0, updaters: {
                  'tap': {true: (_) => 5}
                }),
                color: ColorEncode(value: Defaults.primaryColor, updaters: {
                  'tap': {false: (color) => color.withAlpha(100)}
                }),
              )
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {'tap': PointSelection(dim: Dim.x)},
            tooltip: TooltipGuide(),
            crosshair: CrosshairGuide(),
          ),
        ),
      ],
    );
  }
}
