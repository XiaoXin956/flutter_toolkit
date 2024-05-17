# Flutter 笔记 

****

```dart
Release
Android
flutter build apk
flutter build apk --release
flutter build apk --debug
--target-platform=<value>  可选的值为 android-arm、android-arm64、android-x86、android-x64
--split-per-abi：启用根据 ABI 拆分 APK 功能，将会为每个支持的 ABI 构建一个 APK 包。默认情况下，Flutter 只会构建一个 APK 包，并支持所有的 ABI。
--no-sound-null-safety：禁用空安全检查。通常情况下，Flutter 会检查您的代码是否符合空安全规范。如果您的代码中包含了不符合规范的代码，那么您需要将此选项设置为 true 以便构建 APK。
--build-name=<value>：指定构建版本名称。
--build-number=<value>：指定构建版本号。
--flavor=<value>：指定所需的构建风格。例如，您可以使用 --flavor=production 构建一个生产环境版本的 APK。
--dart-define=<key=value>：定义一个构建变量。这个选项可以用于在构建时传递参数。例如，您可以使用 --dart-define=API_HOST=example.com 来定义一个名为 API_HOST 的构建变量，该变量的值为 example.com。
--target=<path>：指定应用程序的入口点。默认情况下，Flutter 会查找 lib/main.dart 文件作为应用程序的入口点。
--obfuscate --split-debug-info=/<project-name>/<directory>： 开启Dart混淆，并将符号表导出到指定目录


--dart-define=API_URL=值

接收使用
String.fromEnvironment("API_URL",defaultValue: "https://app.watsonerp.com/")

```


**flutter bloc**

BlocProvider 提供一个 BloC 实例，在child 的Widget 里面可以使用

```dart
// 单个
BlocProvider<XXXBloc>(create:(BuildContext context) => XXXBloc(),
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

key
局部localKey
ValueKey  对比 值
ObjectKey  对比 对象 是否为同一个
UniqueKey  直接生成唯一key

全局
globalKey


向下传递约束，向上传递尺寸，上层widget 决定下层widget 位置

