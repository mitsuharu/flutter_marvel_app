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
    required this.hasNext,
    this.name,
    this.characterId,
  });
  late final int offset;
  late final int limit;
  late final int total;
  late final bool hasNext;
  final String? name;
  final String? characterId;

  static initialState() {
    return ApiParam(offset: 0, limit: 20, total: 0, hasNext: true);
  }

  ApiParam copyWith({
    int? offset,
    int? limit,
    int? total,
    bool? hasNext,
    String? name,
    String? characterId,
  }) {
    return ApiParam(
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        total: total ?? this.total,
        hasNext: hasNext ?? this.hasNext,
        name: name ?? this.name,
        characterId: characterId ?? this.characterId);
  }
}
