import 'package:geo_locator_app/domain/entities/location_action.dart';

abstract class DbRepository {
  Future<List<LocationAction>> fetchAllLocationActions();

  Future<void> addNewLocationAction(LocationAction action);

  Future<void> deleteAllLocationActions();
}