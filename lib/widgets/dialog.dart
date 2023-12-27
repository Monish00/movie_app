import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

class Appdialog {
  static Appdialog dialog = Appdialog();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void setupLocator() {
    locator.registerLazySingleton(() => Appdialog());
  }

  Future<void> alertDialog(String message) async {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
