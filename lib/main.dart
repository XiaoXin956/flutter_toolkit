import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolkit/base/top_context.dart';
import 'package:flutter_toolkit/ble/blue_list_page.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/generated/l10n.dart';
import 'package:flutter_toolkit/page/animation_page.dart';
import 'package:flutter_toolkit/page/cxc_home_page.dart';
import 'package:flutter_toolkit/page/data_load_page.dart';
import 'package:flutter_toolkit/page/language_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => LanguageBloc()..add(LanguageGetTypeEvent()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: NavigatorProvider.navigatorKey,
          title: 'Flutter toolkit',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage(),
          // home: BlueListPage(),
          // home: BlocBuilder<LanguageBloc, LanguageState>(
          //   builder: (BuildContext context, LanguageState state) {
          //     return HomePage(title: 'Flutter toolkit');
          //   },
          // ),
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: const [
            Locale("zh"),
            Locale("en"),
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Wrap(
          children: <Widget>[
            TextButton(onPressed: () {
              context.read<LanguageBloc>().add(LanguageGetTypeEvent());
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return LanguagePage();
              }));
            }, child: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (BuildContext context, LanguageState state) {
                return Text("${S.of(context).select_language}");
              },
            )),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return CxcHomePage();
                  }));
                },
                child: Text("cxc首页")),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return DataLoadPage();
                  }));
                },
                child: Text("数据加载")),

            // 语言选择
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return LanguagePage();
                  }));
                },
                child: Text("语言选择")),

            // 语言选择
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return BlueListPage();
                  }));
                },
                child: Text("Ble")),

            // 动画
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return AnimationPage();
                  }));
                },
                child: Text("Ble")),


            // 图表
            TextButton(
                onPressed: () {

                },
                child: Text("Graphic")),




          ],
        ),
      ),
    );
  }
}
