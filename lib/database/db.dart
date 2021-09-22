import 'package:flutter_marvel_app/api/models/characters_response.dart' as ch;
import 'package:flutter_marvel_app/api/models/character_series_response.dart'
    as cs;
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
part 'db.g.dart';

@DataClassName("CharacterData")
class Character extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get thumbnailUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("SeriesData")
class Series extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get thumbnailUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Character, Series])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(VmDatabase.memory());

  @override
  int get schemaVersion => 1;

  Stream<CharacterData> getCharacter(String id) {
    return (select(character)..where((t) => t.id.equals(id))).watchSingle();
  }

  Stream<List<SeriesData>> streamCharacterSeries(String chracterId) {
    return (select(series)..where((tbl) => tbl.characterId.equals(chracterId)))
        .watch();
  }

  Stream<List<CharacterData>> streamCharacters() {
    return (select(character)).watch();
  }

  Future<int> addCharacterData(CharacterData entry) {
    return into(character).insert(entry);
  }

  Future<int> deleteCharacterData() {
    return delete(character).go();
  }

  Future<int> deleteSeriesData() {
    return delete(series).go();
  }

  Future<void> insertCharacterFromApi(List<ch.Result> results) async {
    var rows = results
        .map((e) => CharacterCompanion.insert(
            id: e.id.toString(),
            name: e.name,
            description: e.description,
            thumbnailUrl: thumbnailUrl(e.thumbnail)))
        .toList();
    await batch((batch) {
      batch.insertAll(character, rows);
    });
  }

  Future<void> insertSeriesFromApi(
      String characterId, List<cs.Result> results) async {
    print("insertSeriesFromApi characterId: $characterId, ${results.length}");

    try {
      var rows = results
          .map((e) => SeriesCompanion.insert(
              id: e.id.toString(),
              characterId: characterId,
              title: e.title,
              description: e.description ?? "",
              url: e.urls.isNotEmpty ? e.urls[0].url : "",
              thumbnailUrl: csThumbnailUrl(e.thumbnail)))
          .toList();
      await batch((batch) {
        batch.insertAll(series, rows);
      });
    } catch (error) {
      // すでにあるので不要
      print("insertSeriesFromApi $error");
    }
  }
}

String thumbnailUrl(ch.Thumbnail thumbnail) {
  if (thumbnail.path.isNotEmpty && thumbnail.extension.isNotEmpty) {
    return thumbnail.path + "." + thumbnail.extension;
  }
  return '';
}

String csThumbnailUrl(cs.Thumbnail thumbnail) {
  if (thumbnail.path.isNotEmpty && thumbnail.extension.isNotEmpty) {
    return thumbnail.path + "." + thumbnail.extension;
  }
  return '';
}
