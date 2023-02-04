import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  //global instance of the database
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  //private constructor
  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 20, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';
    final dateType = 'DATE NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes(
  ${NoteFields.id} $idType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $intType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
)
''');

    await db.execute('''
CREATE TABLE $tableGado(
  ${GadoFields.id} $idType,
  ${GadoFields.nome} $textType,
  ${GadoFields.numero} $textType,
  ${GadoFields.dataNascimento} $textType,
  ${GadoFields.dataBaixa} $textType,
  ${GadoFields.motivoBaixa} $textType,
  ${GadoFields.partosNaoLancados} $textType,
  ${GadoFields.partosTotais} $textType,
  ${GadoFields.lote} $textType,
  ${GadoFields.nomeMae} $textType,
  ${GadoFields.nomePai} $textType,
  ${GadoFields.numeroMae} $textType,
  ${GadoFields.numeroPai} $textType
  )
''');
  }

  Future<Object> create(Object object, String tableName) async {
    final db = await instance.database;

    if (tableName == 'gado') {
      Gado gado = object as Gado;
      final id = await db.insert(tableGado, gado.toJson());
      return gado.copy(id: id);
    } else {
      Note note = object as Note;
      final id = await db.insert(tableGado, note.toJson());
      return note.copy(id: id);
    }
    // final json = note.toJson();

    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';

    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';

    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Object>> readAllNotes(String table) async {
    final db = await instance.database;

    if (table == "gado") {
      final orderBy = '${GadoFields.nome} ASC';

      final result =
          await db.rawQuery('SELECT * FROM $tableGado ORDER BY $orderBy');

      return result.map((json) => Gado.fromJson(json)).toList();
    } else {
      final orderBy = '${NoteFields.time} ASC';

      final result =
          await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

      return result.map((json) => Note.fromJson(json)).toList();
    }
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
