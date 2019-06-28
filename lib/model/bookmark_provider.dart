import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:unitice/model/post.dart';

class BookmarkProvider {
  Database _database;
  final String _databaseName = "bookmark";

  Future open() async {
    final path = await getDatabasesPath() + "$_databaseName.db";
    _database = await openDatabase(path, version: 1,
        onCreate: (_database, version) async {
      final sql = """
      create table $_databaseName (
        number integer not null,
        title text not null,
        date text not null,
        link text not null,
        note text,
        isNotice integer not null
      )
      """;
      await _database.execute(sql);
    });
  }

  Future<Post> insert(Post post) async {
    await _database.insert(_databaseName, post.toMap());
    return post;
  }

  Future<List<Post>> readAll() async {
    final maps = await _database.query(_databaseName);
    if (maps.isNotEmpty) {
      return maps.map((map) => Post.fromMap(map)).toList();
    }
    return null;
  }

  Future<int> deleteByTitle(String title) async {
    return await _database
        .delete(_databaseName, where: "title = ?", whereArgs: [title]);
  }

  Future<int> deleteAll() async {
    return await _database.delete(_databaseName);
  }

  Future close() async => _database.close();
}
