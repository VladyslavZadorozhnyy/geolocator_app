import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/domain/entities/location_point.dart';

import '../../domain/repositories/api_repository.dart';
import 'db_repository_impl.dart';

class ApiRepositoryImpl implements ApiRepository {
  const ApiRepositoryImpl({required this.dbRepository});

  final DbRepositoryImpl dbRepository;

  @override
  Future<LocationAction> requestLocation() async {
    try {
      DateTime startTime = DateTime.now();
      const MethodChannel platformChannel = MethodChannel('geolocator_app_channel_name');

      final String stringResult = await platformChannel.invokeMethod('getLocationFromNative');
      final jsonResult = json.decode(stringResult);

      int endTime = DateTime.now().millisecondsSinceEpoch;
      LocationAction result = LocationAction(
        value: LocationPoint(
          longitude: double.parse(jsonResult["longitude"]),
          latitude: double.parse(jsonResult["latitude"]),
        ),
        timeConsumed: endTime - startTime.millisecondsSinceEpoch,
        retrieveDate: DateFormat('dd-MM-yyyy').format(startTime),
      );

      await dbRepository.addNewLocationAction(result);
      return result;
    } on Exception catch (e) {
      return LocationAction(
        value: null,
        timeConsumed: -1,
        retrieveDate: "Exception found: $e",
      );
    }
  }
}