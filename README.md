# flutter_toolkit
****
**flutter bloc**

BlocProvider 提供一个 BloC 实例，在child 的Widget 里面可以使用

```dart in html
 
// 单个
BlocProvider(create:(BuildContext context) => XXXBloc(),
  child:Widget();
);

// 多个
MultiBlocProvider(
 providers: [
          BlocProvider(create:(BuildContext context) => XXXABloc());
          BlocProvider(create:(BuildContext context) => XXXBBloc());
          BlocProvider(create:(BuildContext context) => XXXCBloc());
        ],
 child: Widget();
);

```

BlocBuilder 用于构建Widget
```dart
 
BlocBuilder<LanguageBloc, LanguageState>(
  builder: (BuildContext context, LanguageState state) {
    return Text("${S.of(context).select_language}");
  }
);

```

BlocSelector 是BlocBuilder 的变体，可以选择和提取bloc 状态流中的特定值，并提供给
Widget 渲染
```dart
BlocSelector<LanguageBloc, LanguageState, String>(
            selector: (LanguageState state) {
              if (state is LanguageRefreshState) {
                return state.selectLocal;
              } else {
                return "";
              }
            },
            builder: (BuildContext context, String state) {
              return Column(
                children: [
                  Text("${S.of(context).language}"),
                  DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text("en"),
                          value: "en",
                          alignment: Alignment.center,
                        ),
                      ],
                      onChanged: (value) {
                        context
                            .read<LanguageBloc>()
                            .add(LanguageSelectEvent(locale: value.toString()));
                      })
                ],
              );
            },
          )
```






