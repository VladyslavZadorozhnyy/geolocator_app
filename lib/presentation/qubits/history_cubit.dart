import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_locator_app/data/repositories/db_repository_impl.dart';
import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/domain/usecases/retrieve_locations_use_case.dart';

class HistoryCubit extends Cubit<List<LocationAction>?> {
  HistoryCubit() : super(null);

  final RetrieveLocationsUseCase retrieveLocationsUseCase = RetrieveLocationsUseCase(
    dbRepository: DbRepositoryImpl(),
  );

  Future<void> requestLocationsHistory() async {
    emit(await retrieveLocationsUseCase.invoke());
  }
}