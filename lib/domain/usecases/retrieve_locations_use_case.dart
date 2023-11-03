import 'package:geo_locator_app/data/repositories/api_repository_impl.dart';
import 'package:geo_locator_app/data/repositories/db_repository_impl.dart';

import '../entities/location_action.dart';
import '../entities/location_point.dart';

class RetrieveLocationsUseCase {
  const RetrieveLocationsUseCase({required this.dbRepository});

  final DbRepositoryImpl dbRepository;

  Future<List<LocationAction>> invoke() async {
    return await dbRepository.fetchAllLocationActions();
  }
}