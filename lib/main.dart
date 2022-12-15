import 'package:flutter/material.dart';
//import 'package:inherited_widget/home_page.dart';
import 'package:inherited_widget/app.dart';
import 'package:inherited_widget/task_list.dart';

void main() {
  runApp(
    App(
      child: Builder(builder: (context) {
        final AppData data = AppProvider.of(context);
        debugPrint("mode : ${data.themeMode}");
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: data.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home:const TaskListView(),
        );
      }),
    ),
  );
}
