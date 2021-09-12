enum RequestStatus {
  initial,
  loading,
  success,
  failed,
  empty,
}

class ApiParam {
  ApiParam({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    this.name,
  });
  late final int offset;
  late final int limit;
  late final int total;
  late final int count;
  final String? name;

  static initialState(){
    return ApiParam(offset: 0, limit: 20, total: 0, count: 0);
  }

  ApiParam copyWith({
    int? offset,
    int? limit,
    int? total,
    int? count,
    String? name,
  }) {
    return ApiParam(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      count: count ?? this.count,
      name: name ?? this.name,
      );
  }
}