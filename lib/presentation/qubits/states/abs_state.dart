abstract class AbsState<T> {
  const AbsState({
    required this.status,
    required this.data,
    this.errorMessage = "",
  });

  final Status status;
  final String errorMessage;
  final T? data;
}

enum Status {
  initial,
  success,
  loading,
  failed,
}