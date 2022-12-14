import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/config.dart';
import 'package:hasher/screens/auth/login.dart';

void init() async {
  // init camera
  WidgetsFlutterBinding.ensureInitialized();
}

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Login(),
      builder: (BuildContext context, Widget? child) {
        return FlutterSmartDialog(child: child);
      },
      theme: ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
              primaryColor: Colors.indigo[600],
              buttonTheme: ButtonThemeData(buttonColor: Colors.amber))
          .copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.indigoAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
              )),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.indigoAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
              )),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: Colors.indigoAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                ))),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigoAccent),
                borderRadius:
                    BorderRadius.all(Radius.circular(BORDER_RADIUS)))),
      ),
    );
  }
}
