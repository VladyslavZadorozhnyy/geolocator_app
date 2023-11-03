import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/domain/entities/location_point.dart';

abstract class DbRepository {
  Future<List<LocationAction>> fetchAllLocationActions();

  Future<void> addNewLocationAction(LocationAction action);

  Future<List<LocationPoint>> fetchAllLocationPoints();

  Future<void> deleteAllLocationActions();
}