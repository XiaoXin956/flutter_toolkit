import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolkit/blocs/language/language_bloc.dart';
import 'package:flutter_toolkit/blocs/language/language_event.dart';
import 'package:flutter_toolkit/blocs/language/language_state.dart';
import 'package:flutter_toolkit/generated/l10n.dart';
import 'package:flutter_toolkit/page/details_page.dart';
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
            create: (BuildContext context) =>
                LanguageBloc()..add(LanguageGetTypeEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter toolkit',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (BuildContext context, LanguageState state) {
              return MyHomePage(title: 'Flutter toolkit');
            },
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
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return DetailsPage();
              }));
            }, child: Text("${S.of(context).demo}")),

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
