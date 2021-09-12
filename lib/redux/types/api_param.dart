enum RequestStatus {
  initial,
  loading,
  success,
  failed,
}

class ApiParam {
  ApiParam({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
  });
  late final int offset;
  late final int limit;
  late final int total;
  late final int count;

  static initialState(){
    return ApiParam(offset: 0, limit: 20, total: 0, count: 0);
  }
}