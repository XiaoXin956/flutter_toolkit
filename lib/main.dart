import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/blocs/root_cubit.dart';
import 'package:flutter_toolkit/ex/google/google_login.dart';
import 'package:flutter_toolkit/generated/l10n.dart';
import 'package:flutter_toolkit/navigations/news_route.dart';
import 'package:flutter_toolkit/navigations/route.dart';
import 'package:flutter_toolkit/page/cxc_home_page.dart';
import 'package:flutter_toolkit/page/data_load_page.dart';
import 'package:flutter_toolkit/page/data_select_page/date_select_page.dart';
import 'package:flutter_toolkit/page/isolate/isolate_page.dart';
import 'package:flutter_toolkit/page/language_page.dart';
import 'package:flutter_toolkit/page/refresh/pull_refresh_page.dart';
import 'package:flutter_toolkit/page/rested/all_page.dart';
import 'package:flutter_toolkit/page/state/bloc/count/count_cubit.dart';
import 'package:flutter_toolkit/page/theme_data_page.dart';
import 'package:flutter_toolkit/page/video/video_page.dart';
import 'package:flutter_toolkit/utils/date_tool.dart';
import 'package:flutter_toolkit/utils/utils.dart';
import 'package:provider/provider.dart';

import 'page/channel/channel_page.dart';
import 'page/date_view/date_page.dart';
import 'page/rested/rested_page.dart';
import 'page/state/provider/count_provider.dart';
import 'page/state/state_all_page.dart';
import 'page/storage/hive_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // 初始化页面路由
  MainRouter().initRoute([NewsRoute().routes]);

  HiveUtils.initHive();

  // provider
  MultiProvider providers = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CountProvider()),
    ],
    child: MyApp(),
  );

  runApp(providers);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => CountCubit()),
          BlocProvider(create: (BuildContext context) => RootCubit()),
          BlocProvider(create: (BuildContext context) => LanguageBloc()..add(LanguageGetTypeEvent())),
        ],
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            if (state is RootChangeThemeDataState) {
              themeData = state.themeData;
            }
            return MaterialApp(
              navigatorKey: MainRouter().navigatorKey,
              title: 'Flutter toolkit',
              theme: themeData,
              home: HomePage(
                title: '',
              ),
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
              // onGenerateRoute: ,
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

  late List<Widget> widgets = [
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
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return ThemeDataPage();
          }));
        },
        child: Text("主题修改")),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return VideoPage();
          }));
        },
        child: Text("视频播放")),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return StateAllPage();
          }));
        },
        child: Text("状态管理")),
    Row(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return ChannelPage();
              }));
            },
            child: Text("原生 method channel")),
      ],
    ),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return PullRefreshPage();
          }));
        },
        child: Text("页面刷新")),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return RestedPage();
          }));
        },
        child: Text("二级路由")),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return GoogleLogin();
          }));
        },
        child: Text("谷歌 登錄")),
    TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return HivePage();
          }));
        },
        child: Text("hive 存储")),
    TextButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return DatePage();
          }));
          // List<DateBean> weekData = DateTool.getWeekData(selectData: "2024-03-24");
        },
        child: Text("日期数据")),
    TextButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return IsolatePage();
          }));
          // List<DateBean> weekData = DateTool.getWeekData(selectData: "2024-03-24");
        },
        child: Text("IsolatePage")),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            spacing: 10,
            children: widgets.map((e) => e).toList(),
          ),
        ),
      ),
    );
  }
}
