import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_locator_app/data/repositories/api_repository_impl.dart';
import 'package:geo_locator_app/data/repositories/db_repository_impl.dart';
import 'package:geo_locator_app/domain/entities/location_action.dart';
import 'package:geo_locator_app/domain/usecases/get_location_use_case.dart';
import 'package:geo_locator_app/presentation/qubits/states/abs_state.dart';
import 'package:geo_locator_app/presentation/qubits/states/location_state.dart';

class LocationCubit extends Cubit<LocationState<LocationAction>> {
  LocationCubit() : super(
    LocationState(
        status: Status.initial,
        data: null,
        errorMessage: "",
    ),
  );

  final GetLocationUseCase getLocationUseCase = GetLocationUseCase(
      apiRepository: ApiRepositoryImpl(
        dbRepository: DbRepositoryImpl(),
      ),
  );

  Future<void> requestLocation() async {
    emit(
      LocationState(
          status: Status.loading,
          data: null,
          errorMessage: "",
      ),
    );

    LocationAction requestedLocation = await getLocationUseCase.invoke();

    if (requestedLocation.timeConsumed == -1) {
      emit(
        LocationState(
          status: Status.failed,
          data: null,
          errorMessage: requestedLocation.retrieveDate,
        ),
      );
    } else {
      emit(
          LocationState(
              status: Status.success,
              data: requestedLocation,
              errorMessage: ""
          )
      );
    }
  }
}