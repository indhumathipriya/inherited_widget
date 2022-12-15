import 'package:flutter/material.dart';
import 'package:inherited_widget/model.dart';

class AppProvider extends InheritedWidget {
  final AppData data;

  const AppProvider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppData of(context) {
    AppProvider? result =
        context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(result != null, "No data found");
    return result!.data;
  }
}

class AppData {
  bool isLogged;
  ThemeMode themeMode = ThemeMode.system;
  List<TaskModel> tasks = [];
  AppData({
    required this.isLogged,
  });
}

class App extends StatefulWidget {
  const App({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  AppState createState() => AppState();

  static AppState of(BuildContext context) {
    var result = context.findRootAncestorStateOfType<AppState>();
    assert(result != null, "No data found");
    return result!;
  }
}

class AppState extends State<App> {
  AppData _data = AppData(isLogged: false);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      data: _data,
      // state:this,
      child: widget.child,
    );
  }

  void login() {
    _data = _data..isLogged = true;
    setState(() {});
  }

  void logout() {
    _data = _data..isLogged = false;
    setState(() {});
  }

  void switchThemeMode() {
    int index = _data.themeMode.index > 2 ? 1 : _data.themeMode.index + 1;
    _data = _data..themeMode = ThemeMode.values.elementAt(index);
    setState(() {});
  }

  void saveTask(List<TaskModel> tasks) {
    _data.tasks.addAll(tasks);
    debugPrint(tasks.length.toString());
    setState(() {});
  }
}
