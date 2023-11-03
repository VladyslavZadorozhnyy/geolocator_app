import 'package:geo_locator_app/presentation/qubits/states/abs_state.dart';

class HistoryState<T> extends AbsState<T> {
  HistoryState(
      Status status,
      T data,
      String errorMessage,
      ) : super(
      status: status,
      data: data,
      errorMessage: errorMessage,
  );
}