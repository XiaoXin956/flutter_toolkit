import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_bean.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/generated/l10n.dart';

class LanguagePage extends StatelessWidget {
   LanguagePage({super.key});

  List<LanguageBean> languages = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (BuildContext context, LanguageState state) {
              if (state is LanguageTypeSuccessState) {
                languages.clear();
                languages.addAll(state.languages);
              }
              return BlocSelector<LanguageBloc, LanguageState, LanguageBean>(
                selector: (LanguageState state) {
                  if (state is LanguageRefreshState) {
                    return state.selectLanguageBean;
                  } else {
                    return LanguageBean();
                  }
                },
                builder: (BuildContext context, LanguageBean languageBean) {
                  return Column(
                    children: [
                      Text("${S.of(context).language}"),
                      DropdownButton(
                        items: languages.map((e) => DropdownMenuItem(
                          value: e,
                          alignment: Alignment.center,
                          child: Text("${e.language}"),
                        )).toList(),
                        onChanged: (value) {
                          context.read<LanguageBloc>().add(
                              LanguageSelectEvent(languageBean: value!));
                        },
                        hint: Text("${languageBean.language}"),
                      ),
                      TextButton(onPressed: (){}, child: Text("${S.of(context).reload}")),
                    ],
                  );
                },
              );
            },
          ),


          BlocListener<LanguageBloc, LanguageState>(
            listener: (BuildContext context, LanguageState state) {
              if (state is LanguageRefreshState) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("当前选中的语言${state.selectLanguageBean.language}")));
              }
            },
            child: Container(),
          ),

        ],
      ),
    );
  }
}
