import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'd_state.dart';


class DLogic extends Cubit<DState> {
  List<Map> historyList = [];
  List<Map> favouriteList = [];
  final Map<String, bool> favorites = {};
  late Database db;

  DLogic() :super(InitI());

  createDatabaseAndTable() async {
    await openDatabase(
        "u.db",
        version: 6,
        onCreate: (Database d, int i) async {
          await d.execute
            (
              'create table history '
                  '(id integer primary key,'
                  'title text,url text,imageUrl text)'
          );
          print("history Created !");
          await d.execute
            (
              'create table favourite '
                  '(id integer primary key,'
                  'title text,url text,imageUrl text)'
          );
          print("favourite Created !");
        },
        onUpgrade: (Database d, int i, int m) async {

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

  Future<void> favNews(String title, String url, String imageUrl) async {
    // Toggle favorite status based on the current status
    if (favorites.containsKey(title) && favorites[title]!) {
      await deleteFavouriteElement(title: title);
      favorites[title] = false; // Mark as not favorite
    } else {
      await insertFavouriteElement(title: title, url: url, imageUrl: imageUrl);
      favorites[title] = true; // Mark as favorite
    }
    emit(FavState()); // Emit the new favorite state
  }

  // Add a method to check if a title is favorite
  bool isFavorite(String title) {
    return favorites[title] ?? false;
  }

  insertHistoryElement
      ({
    required String title,
    required String url,
    required String imageUrl
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
          "insert into history (title,url,imageUrl)"
              " values ('$title','$url','$imageUrl') "
      ).then((value) {
        print(" history element Inserted Number  $value");
        print(historyList);
        emit(InsertHistoryElement());
        showHistory().then((value) {
          historyList = value;
          emit(LoadHistoryList());
        });
      });
    });
  }

  Future<List<Map>> showHistory() async {
    return await db.rawQuery("select * from history");
  }

  deleteHistoryElement({required String title}) async {
    await db.rawDelete("delete from history where title = ?", [title]).then((
        value) {
      print("history element Deleted $value");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  clearHistory() async
  {
    await db.rawDelete("delete from history").then((value) {
      print("history cleared");
      emit(DeleteHistoryElement());
      showHistory().then((value) {
        historyList = value;
        emit(LoadHistoryList());
      });
    });
  }

  insertFavouriteElement
      ({
    required String title,
    required String url,
    required String imageUrl
  }) async {
    await db.transaction((txn) async {
      txn.rawInsert(
          "insert into favourite (title,url,imageUrl)"
              " values ('$title','$url','$imageUrl') "
      ).then((value) {
        print(" favourite element Inserted Number  $value");
        emit(InsertFavouriteElement());
        showFavourite().then((value) {
          favouriteList = value;
          emit(LoadFavouriteList());
        });
      });
    });
  }

  Future<List<Map>> showFavourite() async {
    return await db.rawQuery("select * from favourite");
  }

  deleteFavouriteElement({required String title}) async {
    await db.rawDelete("delete from favourite where title = ?", [title]).then((
        value) {
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
        "SELECT * FROM favourite WHERE title = ?", [title]);
    print(" this favourite is ${ans.isNotEmpty}");
    showFavourite().then((value) {
      favouriteList = value;
      emit(LoadFavouriteList());
    });
    return ans.isNotEmpty;
  }
}