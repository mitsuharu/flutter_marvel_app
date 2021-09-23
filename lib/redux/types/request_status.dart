enum RequestStatus {
  initial,
  loading,
  success,
  failed,
  empty,
}

extension RequestStatusExtension on RequestStatus {
  bool get isLoading => this == RequestStatus.loading;
  bool get isEmpty => this == RequestStatus.empty;
}
