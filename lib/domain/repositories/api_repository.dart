import 'package:geo_locator_app/domain/entities/location_action.dart';

abstract class ApiRepository {
  Future<LocationAction> requestLocation();
}