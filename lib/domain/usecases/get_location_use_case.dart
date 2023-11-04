import '../entities/location_action.dart';
import '../repositories/api_repository.dart';

class GetLocationUseCase {
  const GetLocationUseCase({required this.apiRepository});

  final ApiRepository apiRepository;

  Future<LocationAction> invoke() async {
    return await apiRepository.requestLocation();
  }
}