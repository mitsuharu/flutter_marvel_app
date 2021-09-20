import 'package:flutter_marvel_app/api/models/characters_response.dart' as ch;
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
part 'db.g.dart';

class Character extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get thumbnailUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Series extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
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

  Stream<List<CharacterData>> streamCharacters() {
    return (select(character)).watch();
  }

  Future<int> addCharacterData(CharacterData entry) {
    return into(character).insert(entry);
  }

  Future<int> deleteCharacterData() {
    return delete(character).go();
  }

  Future<void> insertCharacterFromApi(List<ch.Result> results) async {
    var rows = results.map((e) => CharacterCompanion.insert(
      id: e.id.toString(),
      name: e.name,
      description: e.description,
      thumbnailUrl: thumbnailUrl(e.thumbnail))).toList();    
    await batch((batch){
      batch.insertAll(character, rows);
    });
  }
}

String thumbnailUrl(ch.Thumbnail thumbnail){
    if (thumbnail.path.isNotEmpty && thumbnail.extension.isNotEmpty){
      return thumbnail.path + "." + thumbnail.extension;
    }
    return '';
  }