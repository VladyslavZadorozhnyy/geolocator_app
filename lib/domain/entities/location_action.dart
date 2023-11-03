import 'package:geo_locator_app/domain/entities/location_point.dart';

class LocationAction {
  const LocationAction({
    required this.value,
    required this.timeConsumed,
    required this.retrieveDate,
  });

  final LocationPoint? value;
  final int timeConsumed;
  final String retrieveDate;
}