import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/classes/MoviesList.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteProvider {
  late Database db;
  Future<Database> open() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String path = appDocDir!.path;
    try {
      db = await openDatabase(
        join(path, 'database.db'),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            '''create table MoviesList( 
              id integer primary key autoincrement, 
              language text not null,
              orginalTitle text not null,
              overView text not null,
              poster text not null,
              releaseDate text not null,
              title text not null,
              voteAverage text not null,
              voteCount text not null
            )''',
          );
        },
      );
      print('success');
    } catch (e) {
      print(e);
    }
    return db;
  }

  Future<void> createItem(MoviesList note) async {
    int result = 0;
    try {
      final Database db = await open();
      result = await db.insert('MoviesList', note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('###########  added $result ###############');
    } catch (e) {
      print(e);
    }
  }

  Future<List> getMovies() async {
    final db = await open();
    final List<Map<String, Object?>> queryResult = await db.query('Notes');
    List<MoviesList> dbMovies =
        queryResult.map((e) => MoviesList.fromMap(e)).toList();
    return dbMovies;
  }

  Future<void> deleteItem(String id) async {
    final db = await open();
    try {
      await db.delete(
        'MoviesList',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
