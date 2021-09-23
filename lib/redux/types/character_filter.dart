class CharacterFilter {
  CharacterFilter({
    this.name,
  });
  final String? name;

  static initialState() {
    return CharacterFilter();
  }

  CharacterFilter copyWith({
    String? name,
  }) {
    return CharacterFilter(name: name ?? this.name);
  }
}
