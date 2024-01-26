

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/blocs/root_cubit.dart';

class ThemeDataPage extends StatelessWidget {
  const ThemeDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题修改"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Theme.of(context).colorScheme;
                },
                child: Text("修改主题")),

            TextButton(
                onPressed: () {
                  ThemeData blueThemeData = ThemeData(
                    primaryColor: Colors.red,
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.red,
                      brightness: Brightness.light,
                    ),
                  );
                  context.read<RootCubit>().changeThemeData(themeData: blueThemeData);
                },
                child: Text("艳丽主题")),

            TextButton(
                onPressed: () {
                  ThemeData blueThemeData = ThemeData(
                    primaryColor: Colors.blue,

                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.blue,
                      brightness: Brightness.light,
                    ),
                  );
                  context.read<RootCubit>().changeThemeData(themeData: blueThemeData);
                },
                child: Text("蓝山主题")),

          ],
        ),
      ),
    );
  }
}
