import 'package:flutter/material.dart';
import 'package:movie_app/helpers/movie_provider.dart';
import 'package:provider/provider.dart';

class FilterDialog {
  static Future<void> filterDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<MoviesProvider>(builder: (context, provider, _) {
          return AlertDialog(
            title: const Text('Filter'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 230,
                    width: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.languageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Checkbox(
                                value: provider.languageList[index].check,
                                onChanged: (bool? value) {
                                  provider.filterCheckBox(
                                      provider.languageList[index]);
                                },
                              ),
                              Text(
                                  provider.languageList[index].orginalLanguage),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  provider.filter();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
