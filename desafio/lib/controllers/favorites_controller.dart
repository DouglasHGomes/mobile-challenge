import 'package:desafio/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesController {
  static final FavoritesController instance = FavoritesController();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await initDB('favorites_database.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $tablePokemon(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${PokemonFields.id} INTEGER NOT NULL UNIQUE, 
          ${PokemonFields.name} TEXT NOT NULL
        )''');
  }

  Future<void> create(PokemonModel pokemon) async {
    final db = await getDatabase();

    await db.insert(tablePokemon, pokemon.toJson());
  }

  Future<bool> readPokemon(int id) async {
    try {
      final db = await getDatabase();

      final maps = await db.query(
        tablePokemon,
        columns: PokemonFields.values,
        where: '${PokemonFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      throw Exception(
          'error:' + error.toString() + 'stacktrace:' + stacktrace.toString());
    }
  }

  Future<List<PokemonModel>> readAllPokemon() async {
    try {
      final db = await getDatabase();

      final result = await db.query(tablePokemon);

      return result.map((json) => PokemonModel.fromJson(json)).toList();
    } catch (error, stacktrace) {
      throw Exception(
          'error:' + error.toString() + 'stacktrace:' + stacktrace.toString());
    }
  }

  Future<int> update(PokemonModel pokemon) async {
    final db = await getDatabase();

    return db.update(
      tablePokemon,
      pokemon.toJson(),
      where: '${PokemonFields.id} = ?',
      whereArgs: [pokemon.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await getDatabase();

    return await db.delete(
      tablePokemon,
      where: '${PokemonFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await getDatabase();

    db.close();
  }
}
