
import 'package:flutter/material.dart';
import 'package:flutter_toolkit/generated/l10n.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${S.of(context).select_language}"),
    );
  }
}
