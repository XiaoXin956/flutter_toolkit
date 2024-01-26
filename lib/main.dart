import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/blocs/root_cubit.dart';
import 'package:flutter_toolkit/generated/l10n.dart';
import 'package:flutter_toolkit/navigations/news_route.dart';
import 'package:flutter_toolkit/navigations/route.dart';
import 'package:flutter_toolkit/page/cxc_home_page.dart';
import 'package:flutter_toolkit/page/data_load_page.dart';
import 'package:flutter_toolkit/page/language_page.dart';
import 'package:flutter_toolkit/page/theme_data_page.dart';

void main() {
  
  // 初始化页面路由
  MainRouter().initRoute([NewsRoute().routes]);
  
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider( create: (BuildContext context) =>RootCubit()),

          BlocProvider( create: (BuildContext context) =>LanguageBloc()..add(LanguageGetTypeEvent())),
        ],
        child: BlocBuilder<RootCubit,RootState>(
          builder: (context,state){
            if(state is RootChangeThemeDataState){
              themeData = state.themeData;
            }
            return MaterialApp(
              navigatorKey: MainRouter().navigatorKey,
              title: 'Flutter toolkit',
              theme: themeData,
              home: HomePage(title: '',),
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
            );
          },
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () {
              context.read<LanguageBloc>().add(LanguageGetTypeEvent());
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LanguagePage();
              }));
            }, child: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (BuildContext context, LanguageState state) {
                return Text("${S.of(context).select_language}");
              },
            )),

            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return CxcHomePage();
                  }));}, child: Text("cxc首页")),

            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return DataLoadPage();
                  }));}, child: Text("数据加载")),
            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ThemeDataPage();
                  }));}, child: Text("主题修改")),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
