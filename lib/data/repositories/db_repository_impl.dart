import 'package:geo_locator_app/domain/entities/location_point.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/location_action.dart';
import '../../domain/repositories/db_repository.dart';

class DbRepositoryImpl implements DbRepository {

  static Future<void> _createTable(Database database) async {
    await database.execute("""CREATE TABLE pointActions(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        timeConsumed INTEGER,
        retrievedTime TEXT,
        longitude REAL,
        latitude REAL
      )
      """);
  }

  static Future<Database> _getDbInstance() async {
    return openDatabase(
      'geolocatorDb.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await _createTable(database);
      },
    );
  }

  @override
  Future<void> addNewLocationAction(LocationAction action) async {
    Map<String, dynamic> itemJson = {
      'timeConsumed': action.timeConsumed,
      'retrievedTime': action.retrieveDate,
      'longitude': action.value?.longitude ?? 0,
      'latitude': action.value?.latitude ?? 0,
    };

    final dbInstance = await _getDbInstance();
    await dbInstance.insert(
      'pointActions',
      itemJson,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<LocationAction>> fetchAllLocationActions() async {
    final List<LocationAction> result = [];

    final dbInstance = await _getDbInstance();
    var queryResult = await dbInstance.query('pointActions', orderBy: "id");

    for (var element in queryResult) {
      result.add(
          LocationAction(
              value: LocationPoint(
                  longitude: double.parse(element["longitude"].toString()),
                  latitude: double.parse(element["latitude"].toString()),
              ),
              timeConsumed: int.parse(element["timeConsumed"].toString()),
              retrieveDate: element["retrievedTime"].toString(),
          )
      );
    }
    return result;
  }

  @override
  Future<List<LocationPoint>> fetchAllLocationPoints() async {
    final dbInstance = await _getDbInstance();
    var queryResult = await dbInstance.query('pointActions', orderBy: "id");
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllLocationActions() async {
    final db = await _getDbInstance();
    try {
      await db.delete('pointActions');
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}