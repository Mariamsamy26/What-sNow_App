import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'd_state.dart';

class DLogic extends Cubit<DState> {
  List<Map> historyList = [];
  List<Map> favouriteList = [];
  late Database db;

  DLogic() : super(InitI());

  Future<void> createDatabaseAndTable() async {
    await openDatabase(
      "u.db",
      version: 4,
      onCreate: (Database d, int version) async {
        // Create both tables when the database is created for the first time
        await d.execute(
          'CREATE TABLE IF NOT EXISTS history '
              '(id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT)',
        );
        await d.execute(
          'CREATE TABLE IF NOT EXISTS favourite '
              '(id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT)',
        );
        print("Tables created on first creation!");
      },
      onUpgrade: (Database d, int oldVersion, int newVersion) async {
        // Ensure the favourite table is created during an upgrade if missing
        if (oldVersion < 4) {
          await d.execute(
            'CREATE TABLE IF NOT EXISTS favourite '
                '(id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT)',
          );
          print("Favourite table created on upgrade!");
        }
      },
      onOpen: (Database d) async {
        db = d;
        print("Database opened!");

        // Ensure favourite table exists in case it was missed
        await db.execute(
          'CREATE TABLE IF NOT EXISTS favourite '
              '(id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT)',
        );

        // Load history and favourite lists on database open
        historyList = await showHistory();
        emit(LoadHistoryList());
        favouriteList = await showFavourite();
        emit(LoadFavouriteList());
      },
    ).then((v) {
      db = v;
      emit(CreateTables());
    });
  }

  // Insert into History Table
  Future<void> insertHistoryElement({
    required String title,
    required String url,
    required String imageUrl,
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
        "INSERT INTO history (title, url, imageUrl) "
            "VALUES ('$title', '$url', '$imageUrl')",
      ).then((value) {
        print("History element inserted: $value");
        emit(InsertHistoryElement());
        showHistory().then((value) {
          historyList = value;
          emit(LoadHistoryList());
        });
      });
    });
  }

  // Fetch History from Database
  Future<List<Map>> showHistory() async {
    return await db.rawQuery("SELECT * FROM history");
  }

  // Delete a History Element
  Future<void> deleteHistoryElement({required String title}) async {
    await db.rawDelete("DELETE FROM history WHERE title = ?", [title]).then((value) {
      print("History element deleted: $value");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  // Clear all History Elements
  Future<void> clearHistory() async {
    await db.rawDelete("DELETE FROM history").then((value) {
      print("History cleared");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  // Insert into Favourite Table
  Future<void> insertFavouriteElement({
    required String title,
    required String url,
    required String imageUrl,
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
        "INSERT INTO favourite (title, url, imageUrl) "
            "VALUES ('$title', '$url', '$imageUrl')",
      ).then((value) {
        print("Favourite element inserted: $value");
        emit(InsertFavouriteElement());
        showFavourite().then((value) {
          favouriteList = value;
          emit(LoadFavouriteList());
        });
      });
    });
  }

  // Fetch Favourites from Database
  Future<List<Map>> showFavourite() async {
    if (db != null) {
      return await db.rawQuery("SELECT * FROM favourite");
    } else {
      print("Database is not initialized.");
      return [];
    }
  }

  // Delete a Favourite Element
  Future<void> deleteFavouriteElement({required String title}) async {
    await db.rawDelete("DELETE FROM favourite WHERE title = ?", [title]).then((value) {
      print("Favourite element deleted: $value");
      emit(DeleteFavouriteElement());
      showFavourite().then((value) {
        favouriteList = value;
        emit(LoadFavouriteList());
      });
    });
  }

  // Function to check if a Favourite Element Exists by Title
  Future<bool> searchByTitle({required String title}) async {
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM favourite WHERE title = ?",
      [title],
    );
    print("Favourite exists: ${result.isNotEmpty}");
    return result.isNotEmpty;
  }
}
