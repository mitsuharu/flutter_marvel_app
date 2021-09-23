class SeriesFilter {
  SeriesFilter({
    required this.characterId,
  });
  final String characterId;

  static initialState() {
    return SeriesFilter(characterId: "");
  }

  SeriesFilter copyWith({
    String? characterId,
  }) {
    return SeriesFilter(characterId: characterId ?? this.characterId);
  }
}
