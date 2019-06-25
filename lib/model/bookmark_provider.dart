import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:unitice/model/post.dart';

class BookmarkProvider {
  Database database;
  final String databaseName = "bookmark";

  Future open() async {
    final path = await getDatabasesPath() + "$databaseName.db";
    database = await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      final sql = """
      create table $databaseName (
        number integer not null,
        title text not null,
        date text not null,
        link text not null,
        note text,
        isNotice integer not null
      )
      """;
      await database.execute(sql);
    });
  }

  Future<Post> insert(Post post) async {
    await database.insert(databaseName, post.toMap());
    return post;
  }

  Future<List<Post>> readAll() async {
    List<Map> maps = await database.query(databaseName);
    if (maps.isNotEmpty) {
      return maps.map((map) => Post.fromMap(map));
    }
    return null;
  }

  Future<int> deleteByTitle(String title) async {
    return await database
        .delete(databaseName, where: "title = ?", whereArgs: [title]);
  }

  Future<int> update(Post post) async {
    return await database.update(databaseName, post.toMap(),
        where: "title = ?", whereArgs: [post.title]);
  }

  Future close() async => database.close();
}
