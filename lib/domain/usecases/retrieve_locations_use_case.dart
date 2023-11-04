import '../entities/location_action.dart';
import '../repositories/db_repository.dart';

class RetrieveLocationsUseCase {
  const RetrieveLocationsUseCase({required this.dbRepository});

  final DbRepository dbRepository;

  Future<List<LocationAction>> invoke() async {
    return await dbRepository.fetchAllLocationActions();
  }
}