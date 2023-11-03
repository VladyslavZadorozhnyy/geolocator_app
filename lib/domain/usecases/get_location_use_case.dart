
import 'package:geo_locator_app/data/repositories/api_repository_impl.dart';

import '../entities/location_action.dart';

class GetLocationUseCase {
  const GetLocationUseCase({required this.apiRepository});

  final ApiRepositoryImpl apiRepository;

  Future<LocationAction> invoke() async {
    return await apiRepository.requestLocation();
  }
}