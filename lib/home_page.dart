import 'package:flutter/material.dart';
import 'package:inherited_widget/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ancestor
    final AppState app = App.of(context);
    //
    final AppData data = AppProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "InheritedWidget",
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("is Logged : ${data.isLogged}"),
          Text("Appearence : ${data.themeMode.name}"),
          TextButton(
            onPressed: () {
              if (data.isLogged) {
                app.logout();
              } else {
                app.login();
              }
            },
            child: Builder(builder: (context) {
              if (data.isLogged) {
                return const Text("Logout");
              } else {
                return const Text("Login");
              }
            }),
          ),
          ElevatedButton(
            onPressed: () {
              app.switchThemeMode();
            },
            child: const Text("Switch Mode"),
          ),
        ]),
      ),
    );
  }
}
