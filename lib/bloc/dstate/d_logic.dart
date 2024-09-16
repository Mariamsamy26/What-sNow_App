import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'd_state.dart';

class DLogic extends Cubit<DState> {
  List<Map> historyList = [];
  List<Map> favouriteList = [];
  late String userID = "";
  late Database db;

  DLogic() : super(InitI());

  void initDB() async {
    if (userID.isNotEmpty) {
      createDatabaseAndTable();
    } else {
      print("userID is not set");
    }
  }

  createDatabaseAndTable() async {
    await openDatabase(
        "u.db",
        version: 7, // increment the version number
        onCreate: (Database d, int i) async {
          await d.execute(
              'CREATE TABLE history (id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT, userID TEXT)'
          );
          print("history Created !");
          await d.execute(
              'CREATE TABLE favourite (id INTEGER PRIMARY KEY, title TEXT, url TEXT, imageUrl TEXT, userID TEXT)'
          );
          print("favourite Created !");
        },
        onUpgrade: (Database d, int i, int m) async {
          // handle upgrades here
        },
        onOpen: (Database d) {
          print("history database open");
          print("favourite database open");
        }
    ).then((v) {
      db = v;
      emit(CreateTables());
    });

    showHistory().then((value) {
      historyList = value;
      emit(LoadHistoryList());
    });
    showFavourite().then((value) {
      favouriteList = value;
      emit(LoadFavouriteList());
    });
  }

  insertHistoryElement({
    required String title,
    required String url,
    required String imageUrl,
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
          "INSERT INTO history (title, url, imageUrl, userID) VALUES ('$title', '$url', '$imageUrl', '$userID')"
      ).then((value) {
        print("history element Inserted Number $value");
        emit(InsertHistoryElement());
        showHistory().then((value) {
          historyList = value;
          emit(LoadHistoryList());
        });
      });
    });
  }

  Future<List<Map>> showHistory() async {
    return await db.rawQuery("SELECT * FROM history WHERE userID = ?", [userID]);
  }

  deleteHistoryElement({required String title}) async {
    await db.rawDelete("DELETE FROM history WHERE title = ? AND userID = ?", [title, userID]).then((value) {
      print("history element Deleted $value");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  clearHistory() async {
    await db.rawDelete("DELETE FROM history WHERE userID = ?", [userID]).then((value) {
      print("history cleared");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  insertFavouriteElement({
    required String title,
    required String url,
    required String imageUrl,
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
          "INSERT INTO favourite (title, url, imageUrl, userID) VALUES ('$title', '$url', '$imageUrl', '$userID')"
      ).then((value) {
        print("favourite element Inserted Number $value");
        emit(InsertFavouriteElement());
        showFavourite().then((value) {
          favouriteList = value;
          emit(LoadFavouriteList());
        });
      });
    });
  }

  Future<List<Map>> showFavourite() async {
    return await db.rawQuery("SELECT * FROM favourite WHERE userID = ?", [userID]);
  }

  deleteFavouriteElement({required String title}) async {
    await db.rawDelete("DELETE FROM favourite WHERE title = ? AND userID = ?", [title, userID]).then((value) {
      print("favourite element Deleted $value");
      emit(DeleteFavouriteElement());
      showFavourite().then((value) {
        favouriteList = value;
        emit(LoadFavouriteList());
      });
    });
  }

  // Function to check if a row with a specific title exists
  Future<bool> searchByTitle({required String title}) async {
    final List<Map<String, dynamic>> ans = await db.rawQuery(
        "SELECT * FROM favourite WHERE title = ? AND userID = ?", [title, userID]);
    print("this favourite is ${ans.isNotEmpty}");
    showFavourite().then((value) {
      favouriteList = value;
      emit(LoadFavouriteList());
    });
    return ans.isNotEmpty;
  }
  Future<int?> countHistoryRowsForUser() async {
    final count = await db.rawQuery("SELECT COUNT(*) FROM history WHERE userID = ?", [userID]);
    print("$count the lists are : $historyList" );
    return count.first["COUNT(*)"] as int ;
  }
  Future<int?> countFavouriteRowsForUser() async {
    final count = await db.rawQuery("SELECT COUNT(*) FROM favourite WHERE userID = ?", [userID]);
    print("$count the lists are : $historyList" );
    return count.first["COUNT(*)"] as int ;
  }

  void setUserID(String newUserID) {
    userID = newUserID;
    emit(SetUserID());
    initDB();
  }
}