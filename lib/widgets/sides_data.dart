import 'package:flutter/material.dart';

class SidesDataView extends StatefulWidget {
  Set<String> data = {};
  double fontSize = 16;
  double height;
  Function(int)? onTouchLetter;

  SidesDataView({super.key, required this.data, required this.fontSize, required this.height, this.onTouchLetter});

  @override
  State<SidesDataView> createState() => _SidesDataState();
}

class _SidesDataState extends State<SidesDataView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: widget.data
            .map((e) => Container(height: widget.height / widget.data.length, alignment: Alignment.center, child: Text(e, style: TextStyle(fontSize: widget.fontSize))))
            .toList(),
      ),
      onVerticalDragUpdate: (details) {
        var dy = details.localPosition.dy;
        int position = (dy / widget.data.length).floor();
        // 当前选择的字母下标
        if (position < 0 || position > widget.data.length - 1) {
          return;
        }
        if (widget.onTouchLetter != null) {
          widget.onTouchLetter!(position);
        }
      },
    );
  }
}
