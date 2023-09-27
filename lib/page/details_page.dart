
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/generated/l10n.dart';

import '../blocs/language/language_event.dart';
import 'language_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text("${S.of(context).select_language}"),

          TextButton(onPressed: (){
            context.read<LanguageBloc>().add(LanguageGetTypeEvent());
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return LanguagePage();
                }));
          }, child: Text("选择")),

        ],
      ) ,
    );
  }
}
