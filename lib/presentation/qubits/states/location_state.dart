import 'abs_state.dart';

class LocationState<T> extends AbsState<T> {
  LocationState({
    required Status status,
    required T? data,
    required String errorMessage,
  }) : super(
    status: status,
    data: data,
    errorMessage: errorMessage,
  );
}